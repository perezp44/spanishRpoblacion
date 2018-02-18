#- me da x mirar datos del padron Continuo y acabo bajandome todos

library(stringr)
library(readr)
library(tidyverse)
library(personal.pjp)   #- personal packages
library(readxl)
library(readr)
library(usethis)

#------------------------------- SI, ya es PADRON CONTINUO
#- son microdatos, cada registro tiene 102 caracteres para conformar 5 varibles


#- DICCIONARIOs
dicc_1 <- read_excel("./data-raw/datos_padron_entidades_10_17/DisenioRegistro.xls", skip = 3, sheet = "dicc_pjp")   #- las def. de las variables
dicc_2 <- read_excel("./data-raw//datos_padron_entidades_10_17/DisenioRegistro.xls", sheet = "dicc_pjp_2")   #- las def. de las variables

#- files with data
aa <- list.files("./data-raw//datos_padron_entidades_10_17/datos/") #- un vector con los nombres de los ficheros de datos
#- reading the data   #- only basers use list.files ; usa dir()

df <-  read_fwf(paste0("./data-raw/datos_padron_entidades_10_17/datos/",aa[1]), fwf_widths(c(102)), locale = locale(encoding = "WINDOWS-1252"))   %>%  mutate(anyo = str_extract(aa[1], "(........)$")) #- el primer archivo
for (ii in 2:length(aa)){
  bb <- read_fwf(paste0("./data-raw/datos_padron_entidades_10_17/datos/",aa[ii]), fwf_widths(c(102)), locale = locale(encoding = "WINDOWS-1252"))  %>%  mutate(anyo = str_extract(aa[ii], "(........)$"))
  df <- bind_rows(df, bb)
}
rm(aa,bb,ii)
#--------- OK, leidos

#-- sacar codigos
df <- df %>% mutate(anyo = str_extract(anyo, "^(....)")) #- ok anyo está ok

for (ii in 1:5){
  df <- df %>% mutate(!!as.character(dicc_1[ii,1]) := substr(X1, dicc_1[ii,3], dicc_1[ii,4]))            #- sexo: 1= H, 6 = M
}
df <- df %>% map(str_trim, side = "both") %>% as_tibble() #- quito espacios en blanco, puede q haya

for (ii in 1:5){
  df <- df %>% mutate(!!as.character(dicc_2[ii,1]) := substr(Code_unidad_poblacional, dicc_2[ii,3], dicc_2[ii,4]))            #- sexo: 1= H, 6 = M
}

#-- arreglar
df <- df %>% map(str_trim, side = "both") %>% as_tibble() #- quito espacios en blanco, puede q haya
#df <- df %>% map(stringi::stri_enc_toutf8) %>% as_tibble() #- al final lo del encoding lo hice arriba


# https://es.wikipedia.org/wiki/Entidad_singular_de_poblaci%C3%B3n
#Las entidades y los núcleos de población están codificados por el Instituto Nacional de Estadística desde el año 1981. Este código está formado por 11 dígitos: (Hay mas explicacion)
#Los códigos se restablecieron en el año 1991 siguiendo el orden alfabético de los núcleos de población dentro de cada entidad singular. A las entidades de nueva creación se les asigna un código correlativo al último existente, y no se reutilizan los de las que desaparecen. Los ayuntamientos deben revisar, al menos una vez al año, la relación de entidades y núcleos de población, y enviarla al Instituto Nacional de Estadística, que las publica anualmente.
# Esta relación sirve de base para la confección del padrón municipal de habitantes.

#- variable que señalice que es cada row (municipio, colectivo etc...
aa <- df %>% filter(anyo == "2017") %>% filter(Provincia == 44) %>% filter(Municipio == 177) #- PANCRUDO

df <- df %>% mutate(TIPO = "44")
df <- df %>% mutate(TIPO = if_else(str_detect(Code_unidad_poblacional, "(000000)$"), "Municipio", TIPO)) #- Marco municipios
df <- df %>% mutate(TIPO = if_else(Entidad_colectiva != "00", "Entidad colectiva", TIPO))                #- marco Entidad Colectiva
df <- df %>% mutate(TIPO = if_else(Entidad_singular != "00", "Entidad singular", TIPO))                  #- marco Entidad singular
df <- df %>% mutate(TIPO = if_else(Nucleo_o_diseminado != "00" & Nucleo_o_diseminado != "99", "Nucleos", TIPO))    #- Nucleos
df <- df %>% mutate(TIPO = if_else(str_detect(Code_unidad_poblacional, "(99)$"), "Diseminados", TIPO))             #- Diseminados

#- Las 3 series de poblacion a numeric
df <- df %>% mutate(Poblacion_Total = as.integer(Poblacion_Total))
df <- df %>% mutate(Poblacion_H = as.integer(Poblacion_H))
df <- df %>% mutate(Poblacion_M = as.integer(Poblacion_M))

#- creacion de INECodMuni (5 digitos que identifican al municipio)
df <- df %>% mutate(INECodMuni = paste0(Provincia, Municipio))
df <- df %>% rename(INECodProv = Provincia)

#- quito variables y reordeno
df <- df %>% select(-c(Municipio, X1))
df <- df %>% select(INECodProv, INECodMuni, Code_unidad_poblacional, Nombre_unidad_poblacional, anyo, Poblacion_Total, Poblacion_H, Poblacion_M, TIPO, everything())


# AÑADIR INECodCCAA, NombreCCAA y NombreProv --------------------------------------------------------
# devtools::install_github("perezp44/spanishRshapes")
library(spanishRshapes)
code_prov <- cod_INE_prov                                                       #- (52 x 4) cargo codigos INE
names(code_prov) <- c("INECodCCAA", "NombreCCAA", "INECodProv", "NombreProv")   #- ajusto nombres
df <- left_join(df, code_prov, by = "INECodProv")                               #- (170.334 x 10)fusiono df con codigos INE



# Señalar los municipios q son capitales de provincia -----------------------------------------------
#devtools::install_github("perezp44/spanishRentidadesIGN")
library(spanishRentidadesIGN)
capitales <- capitales_prov %>% select(INECodMuni) %>% mutate(Capital_prov = 1)

df <- left_join(df, capitales, by = "INECodMuni") %>%
  mutate(Capital_prov = if_else(is.na(Capital_prov), 0, 1) )

# Comprobaciones ------------------------------------------------------------------------------------
aa <- names_v_df_pjp(df)  #- OK numeric etc....
df <- df %>% map(str_trim, side = "both") %>% as_tibble() #- quito espacios en blanco, puede q haya
INE_padron_entidades_10_17 <- df





# use_data(INE_padron_entidades_10_17, overwrite = TRUE) #- lo guarde con esta linea que usa el pkg usethis el 2018-02-17



#--------------- LO DE ABAJO YA SON CALCULOS
#--------------- LO DE ABAJO YA SON CALCULOS no sse usan al guardar los datos en el pkg
#--------------- LO DE ABAJO YA SON CALCULOS



#------------------------------------------------------------ YA CALCULOS YA
aa <- df %>% filter(str_detect(X1 ,"PORTALRUBIO"))

aa <- df %>% filter(anyo == "2017") %>% filter(Provincia == 44) %>% filter(Municipio == 177) #- PANCRUDO


#- municipios en 2017 (EC=00, ES=00 y NUC=00)
aa <- df %>% filter(anyo == "2017")  %>% filter(str_detect(Code_unidad_poblacional, "(000000)$"))
#- nº de municipios por año
aa <- df %>% filter(str_detect(Code_unidad_poblacional, "(000000)$")) %>% group_by(anyo) %>% summarise(NN = n())



#- Entidades Colectivas (EC ≠ 00, ES = 00 y NUC = 00)
aa_colectivas <- df %>% filter(anyo == "2017") %>% filter(Entidad_colectiva != "00" ) %>% filter(str_detect(Code_unidad_poblacional, "(0000)$"))

#- nº de entidades colectivas por año.
aa_colectivas <- df %>% filter(Entidad_colectiva != "00" ) %>% filter(str_detect(Code_unidad_poblacional, "(0000)$")) %>% group_by(anyo) %>% summarise(NN = n())



#- Entidades Singulares (ES != 00 y NUC = 00)

aa_singulares <- df %>% filter(anyo == "2017") %>% filter(Entidad_singular != "00" ) %>% filter(str_detect(Code_unidad_poblacional, "(00)$"))

#- Entidades singulares deshabitados

aa_0 <- df %>% filter(anyo == "2017") %>% filter(Entidad_singular != "00" ) %>% filter(str_detect(Code_unidad_poblacional, "(00)$")) %>% filter(Poblacion_Total == 0)


aa_0 <- df %>% filter(anyo == "2017") %>% filter(Entidad_singular != "00" ) %>% filter(str_detect(Code_unidad_poblacional, "(00)$")) %>% filter(Poblacion_Total != 0 & Poblacion_M == 0)


aa_0 <- df %>% filter(anyo == "2017") %>% filter(Entidad_singular != "00" ) %>% filter(str_detect(Code_unidad_poblacional, "(00)$")) %>% filter(Poblacion_Total != 0 & Poblacion_H == 0)



#- Nucleo o diseminado. Nucleos: NUC !=0  Diseminados: NUC = 99
#- (siempre pertenecen a una entidad singular), los núcleos se identifican por el código NUC ≠ 00 y los diseminados por el código NUC = 99

aa_nucleos <- df %>% filter(anyo == "2017")  %>% filter(Nucleo_o_diseminado != "00" ) %>% filter(Nucleo_o_diseminado != "99")
aa_diseminados <- df %>% filter(anyo == "2017")  %>% filter(str_detect(Code_unidad_poblacional, "(99)$"))



aa <- df %>% filter(anyo == "2010") %>% filter(Provincia == "01") %>% filter(Municipio == "001") #- PANCRUDO

#- Arreglar DATOS INE PADRON para municipios (1996, 1998-2017)

library(stringr)
library(readr)
library(tidyverse)
library(personal.pjp)   #- personal packages
library(readxl)
library(readr)
library(usethis)

#-------
#--- descargo fichero zip con datos municipales de poblacion (2000-2017) y (1996,1998,1999; estos 3 ficheros tienen solo 5 columnas)
# download.file("http://www.ine.es/pob_xls/pobmun.zip", "./datos/pobmub.zip")

#--- dentro hay 1 fichero Excel para cada año. Las estructuras eran parecidas pero hubo q quitar la primera fila en algunos archivos, y en el de 2009 añadir una primera fila


# preparacion para cargar los 18 ficheros de datos 2000-2017 ------------------------------------------------
aa <- dir("./data-raw/datos_padron_municipios_96_17/00s") #- 18 ficheros desde 2000-2017 ; tb hay 3 ficheros con datos de los 90
aa <- paste0("./data-raw/datos_padron_municipios_96_17/00s/", aa)
anyos <- as.list(2000:2017)
nonmbrecitos <- c( "INECodProv", "NombreProv", "CodMuni", "NombreMuni", "Pob_T", "Pob_H", "Pob_M", "anyo")

# cargo los 18 ficheros .xls en la lista dfs ----------------------------------------------------------------
dfs <- map(aa, read_excel , skip = 1)
dfs <- map2(.x = dfs, .y = anyos, dplyr::mutate) #- pongo columna con el año
dfs <- map(dfs, set_names, nonmbrecitos)         #- renombro
df00 <- bind_rows(dfs)                            #- apilo  (146.193 x 8)

# preparacion para cargar los 3 ficheros de datos 1996, 1998 y 1999 -----------------------------------------
# No los puedo cargar juntos porque tienen una columna menos
aa <- dir("./data-raw/datos_padron_municipios_96_17/90s") #- 18 ficheros desde 2000-2017 ; tb hay 3 ficheros con datos de los 90
aa <- paste0("./data-raw/datos_padron_municipios_96_17/90s/", aa)
anyos <- as.list(c(1996L, 1998L, 1999L))
nonmbrecitos <- c( "INECodProv", "CodMuni", "NombreMuni", "Pob_T", "Pob_H", "Pob_M", "anyo")

# cargo los 3 ficheros .xls en la lista dfs ----------------------------------------------------------------
dfs <- map(aa, read_excel , skip = 1)
dfs <- map2(.x = dfs, .y = anyos, dplyr::mutate)  #- pongo columna con el año
dfs <- map(dfs, set_names, nonmbrecitos)          #- renombro
df90 <- bind_rows(dfs)                            #- apilo  (24.296 x 7)
df90 <- df90 %>% mutate(NombreProv = "999") %>%        #- añado columna q falta (habra q arreglarla luego)
        select(INECodProv,NombreProv, everything())    #- reordeno (24.296 x 8)


# fusiono df00 y df90 ---------------------------------------------------------------------------------------
df <- bind_rows(df00, df90)                                                          #- (170.489 x 8)
df <- df %>% mutate(INECodMuni = paste0(INECodProv, CodMuni)) %>% select(-CodMuni)   #- (170.489 x 8)

# arreglar q en los años 2002, 2007 y 2009 hay rows con los totales provinciales ---------------------------- en 2016 esta el total nacional
df <- df %>% filter(!(is.na(NombreMuni)))        #- (170.334 x 8) caen 155 (50 en 2002, 52 en 2007 y 2009 y 1 en 2016)                             #- 146.142 x 8 en 2007 y 2009 habia totales provinciales (hay que quitarlos)
df <- df %>% select(INECodProv, INECodMuni, NombreMuni, Pob_T, Pob_H, Pob_M, anyo)   #- (170.334 x 7) quito NombreProv y reordeno

# OK, leidos, borro todo excepto df -----------------------------------------------------------------
rm(list= ls()[ls()!="df"])

# AÑADIR INECodCCAA, NombreCCAA y NombreProv --------------------------------------------------------
# devtools::install_github("perezp44/spanishRshapes")
library(spanishRshapes)
code_prov <- cod_INE_prov                                                       #- (52 x 4) cargo codigos INE
names(code_prov) <- c("INECodCCAA", "NombreCCAA", "INECodProv", "NombreProv")   #- ajusto nombres
df <- left_join(df, code_prov, by = "INECodProv")                               #- (170.334 x 10)fusiono df con codigos INE

# en 1998 el codigo del municipio se les colo un digito al final ------------------------------------
df <- df %>% mutate(INECodMuni = if_else(anyo == 1998, str_extract(INECodMuni, "^....."), INECodMuni)) #- los del año 1998 les cojo solo los 3 pr
rm(code_prov)


# Señalar los municipios q son capitales de provincia -----------------------------------------------
#devtools::install_github("perezp44/spanishRentidadesIGN")
library(spanishRentidadesIGN)
capitales <- capitales_prov %>% select(INECodMuni) %>% mutate(Capital_prov = 1)

df <- left_join(df, capitales, by = "INECodMuni") %>%
  mutate(Capital_prov = if_else(is.na(Capital_prov), 0, 1) )

# Comprobaciones ------------------------------------------------------------------------------------
df <- df %>% map(str_trim, side = "both") %>% as_tibble() #- quito espacios en blanco, puede q haya
df <- df %>% mutate(Pob_T = as.integer(Pob_T))
df <- df %>% mutate(Pob_H = as.integer(Pob_H))
df <- df %>% mutate(Pob_M = as.integer(Pob_M))
df <- df %>% mutate(anyo = as.integer(anyo))
df <- df %>% mutate(Capital_prov = as.integer(Capital_prov))


# Renaming capital -----------------------------------------------------------------------------------
df <- df %>% rename(capital_prov = Capital_prov)




aa <- names_v_df_pjp(df)  #- OK numeric etc....

INE_padron_muni_96_17 <- df


# use_data(INE_padron_muni_96_17, overwrite = TRUE) #- lo guarde con esta linea que usa el pkg usethis el 2018-02-17



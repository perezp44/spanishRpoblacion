## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", message = FALSE, warning = FALSE
)

## ---- eval = FALSE-------------------------------------------------------
#  # devtools::install_github("perezp44/spanishRpoblacion")
#  library(spanishRpoblacion)
#  df <- INE_padron_muni_96_17

## ---- echo = FALSE-------------------------------------------------------
Pancrudo <- structure(list(X1 = c("44177000000PANCRUDO                                                                  119     72     47", 
"44177000100CERVERA DEL RINCÓN                                                         15      9      6", 
"44177000101CERVERA DEL RINCÓN                                                         15      9      6", 
"44177000200CUEVAS DE PORTALRUBIO                                                       9      7      2", 
"44177000201CUEVAS DE PORTALRUBIO                                                       9      7      2", 
"44177000300PANCRUDO                                                                   77     45     32", 
"44177000301PANCRUDO                                                                   77     45     32", 
"44177000400PORTALRUBIO                                                                18     11      7", 
"44177000401PORTALRUBIO                                                                18     11      7"
), anyo = c("2017", "2017", "2017", "2017", "2017", "2017", "2017", 
"2017", "2017"), Code_unidad_poblacional = c("44177000000", "44177000100", 
"44177000101", "44177000200", "44177000201", "44177000300", "44177000301", 
"44177000400", "44177000401"), Nombre_unidad_poblacional = c("PANCRUDO", 
"CERVERA DEL RINCÓN", "CERVERA DEL RINCÓN", "CUEVAS DE PORTALRUBIO", 
"CUEVAS DE PORTALRUBIO", "PANCRUDO", "PANCRUDO", "PORTALRUBIO", 
"PORTALRUBIO"), Poblacion_Total = c("119", "15", "15", "9", "9", 
"77", "77", "18", "18"), Poblacion_H = c("72", "9", "9", "7", 
"7", "45", "45", "11", "11"), Poblacion_M = c("47", "6", "6", 
"2", "2", "32", "32", "7", "7"), Provincia = c("44", "44", "44", 
"44", "44", "44", "44", "44", "44"), Municipio = c("177", "177", 
"177", "177", "177", "177", "177", "177", "177"), Entidad_colectiva = c("00", 
"00", "00", "00", "00", "00", "00", "00", "00"), Entidad_singular = c("00", 
"01", "01", "02", "02", "03", "03", "04", "04"), Nucleo_o_diseminado = c("00", 
"00", "01", "00", "01", "00", "01", "00", "01"), TIPO = c("Municipio", 
"Entidad singular", "Nucleos", "Entidad singular", "Nucleos", 
"Entidad singular", "Nucleos", "Entidad singular", "Nucleos")), class = c("tbl_df", 
"tbl", "data.frame"), row.names = c(NA, -9L), .Names = c("X1", 
"anyo", "Code_unidad_poblacional", "Nombre_unidad_poblacional", 
"Poblacion_Total", "Poblacion_H", "Poblacion_M", "Provincia", 
"Municipio", "Entidad_colectiva", "Entidad_singular", "Nucleo_o_diseminado", 
"TIPO"))

## ---- echo = FALSE-------------------------------------------------------
library(tidyverse)
bb <- Pancrudo %>% select(X1, Code_unidad_poblacional, Nombre_unidad_poblacional, Poblacion_Total)

knitr::kable(bb)


## ---- eval = FALSE-------------------------------------------------------
#  # devtools::install_github("perezp44/spanishRpoblacion")
#  library(spanishRpoblacion)
#  df <- INE_padron_entidades_10_17

## ---- eval = FALSE-------------------------------------------------------
#  library(tidyverse)
#  Pancrudo <- INE_padron_entidades_10_17 %>%
#              filter(anyo == "2017") %>%
#              filter(INECodMuni == 44177)

## ---- eval = FALSE-------------------------------------------------------
#  #- municipios en 2017 (EC=00, ES=00 y NUC=00)
#  muni_2017 <- INE_padron_entidades_10_17 %>% filter(anyo == "2017")  %>%
#               filter(str_detect(Code_unidad_poblacional, "(000000)$"))

## ---- eval = FALSE-------------------------------------------------------
#  #- nº de municipios por año
#  aa <- INE_padron_entidades_10_17 %>%
#        filter(str_detect(Code_unidad_poblacional, "(000000)$")) %>%
#        group_by(anyo) %>%
#        summarise(NN = n())


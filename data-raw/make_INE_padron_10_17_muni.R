# Fri Feb 09 18:53:12 2018 ------------------------------
# resulta q ya tenia hecho el spanishRpoblacion pkg PERO
# lo normal es que solo use los municipios y que necesite el INECodMuni,
# asi que creo un nuevo fichero de datos


library(tidyverse)
library(spanishRpoblacion)
library(usethis)

INE_padron_10_17_muni <- INE_padron_10_17 %>%
  filter(TIPO == "Municipio") %>%
  select(Nombre_unidad_poblacional,Provincia, Municipio, anyo, Poblacion_Total, Poblacion_H, Poblacion_M) %>%
  mutate(INECodMuni = paste0(Provincia, Municipio)) %>%
  select(INECodMuni, everything())


# use_data(INE_padron_10_17_muni) #- lo guarde con esta linea que usa el pkg usethis el 2018-02-06

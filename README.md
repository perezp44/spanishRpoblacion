
<!-- README.md is generated from README.Rmd. Please edit that file -->
Introducción
============

`spanishRpoblacion` Es un paquete de datos. Contiene datos de población del Padrón. En concreto contiene archivos referentes a dos grupos de datos:

-   Datos referentes a municipios para los años 1996, 1998-2017

-   Datos referentes a unidades poblacionales para el periodo 2010-2017

En ambos casos los datos están sacados del INE. Para facilitar su uso he creado la variable `INECodMuni`, un código de 5 cifras que identifica de manera única los municipios españoles y alguna variable más para identificar la provincia y la C.A. Un poco más de información abajo.

Datos de población para municipios
==================================

El INE tiene [aquí](http://www.ine.es/pob_xls/pobmun.zip) un fichero .zip con los datos de población del Padrón para municipios para los periodos 1996, 1998-2017. Al descomprimir el fichero se obtiene un fichero excel para cada uno de los periodos; es decir 21 ficheros.

Los datos fusionados y convenientemente tratados se ofrecen en el archivo: `INE_padron_muni_96_17`

### Ejemplo

Para cargar el fichero con los datos basta con:

``` r
# devtools::install_github("perezp44/spanishRpoblacion")
library(spanishRpoblacion)
df <- INE_padron_muni_96_17
```

Datos de población para entidades
=================================

Están sacados del INE. Concretamente de [aquí](http://www.ine.es/nomen2/ficheros.do) Así que los datos en realidad provienen del **[Nomenclátor: Población del Padrón Continuo por Unidad Poblacional](http://www.ine.es/nomen2/index.do)**. Me bajé los ficheros de los años 2010 a 2017, ambos incluidos.

Los datos fusionados y convenientemente tratados se ofrecen en el archivo: `INE_padron_entidades_10_17`

Más información sobre los datos refrentes a entidades
-----------------------------------------------------

El INE tiene información detallada [aquí](http://www.ine.es/nomen2/Metodologia.do) del diseño de registro. Yo para entenderlo usé los datos referentes a mi pueblo, lo muestro abajo.

### Mi pueblo

Mi pueblo es Pancrudo, en la provincia de Teruel. Es mi pueblo, pero para el INE es un municipio compuesto de 4 núcleos: Pancrudo, Portalrubio, Cervera del rincón y Cuevas de Portalrubio. Veamos sus registros para 2017

| X1                                     | Code\_unidad\_poblacional | Nombre\_unidad\_poblacional | Poblacion\_Total |
|:---------------------------------------|:--------------------------|:----------------------------|:-----------------|
| 44177000000PANCRUDO 119 72 47          | 44177000000               | PANCRUDO                    | 119              |
| 44177000100CERVERA DEL RINCÓN 15 9 6   | 44177000100               | CERVERA DEL RINCÓN          | 15               |
| 44177000101CERVERA DEL RINCÓN 15 9 6   | 44177000101               | CERVERA DEL RINCÓN          | 15               |
| 44177000200CUEVAS DE PORTALRUBIO 9 7 2 | 44177000200               | CUEVAS DE PORTALRUBIO       | 9                |
| 44177000201CUEVAS DE PORTALRUBIO 9 7 2 | 44177000201               | CUEVAS DE PORTALRUBIO       | 9                |
| 44177000300PANCRUDO 77 45 32           | 44177000300               | PANCRUDO                    | 77               |
| 44177000301PANCRUDO 77 45 32           | 44177000301               | PANCRUDO                    | 77               |
| 44177000400PORTALRUBIO 18 11 7         | 44177000400               | PORTALRUBIO                 | 18               |
| 44177000401PORTALRUBIO 18 11 7         | 44177000401               | PORTALRUBIO                 | 18               |

Mi pueblo tenía en 2017, como podéis ver en la tabla, 77 habitantes, pero el municipio de Pancrudo tenía 119 (somos grandes!!)

Para entender la codificación lo mejor es ir al diseño de registro, pero en [este artículo de la Wiki](https://es.wikipedia.org/wiki/Entidad_singular_de_poblaci%C3%B3n) lo explican bien.

### Ejemplos

Para cargar el fichero con los datos basta con:

``` r
# devtools::install_github("perezp44/spanishRpoblacion")
library(spanishRpoblacion)
df <- INE_padron_entidades_10_17
```

Para ver los registros de pancrudo en 2017:

``` r
library(tidyverse)
Pancrudo <- INE_padron_entidades_10_17 %>% 
            filter(anyo == "2017") %>% 
            filter(INECodMuni == 44177) 
```

Para ver los municipios en 2017 (hay 8.124):

``` r
#- municipios en 2017 (EC=00, ES=00 y NUC=00)
muni_2017 <- INE_padron_entidades_10_17 %>% filter(anyo == "2017")  %>%     
             filter(str_detect(Code_unidad_poblacional, "(000000)$"))
```

Para ver como ha variado el número de municipios en 2010-2017:

``` r
#- nº de municipios por año
aa <- INE_padron_entidades_10_17 %>% 
      filter(str_detect(Code_unidad_poblacional, "(000000)$")) %>%
      group_by(anyo) %>% 
      summarise(NN = n())
```

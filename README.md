
<!-- README.md is generated from README.Rmd. Please edit that file -->
spanishRpoblacion
=================

Es un paquete de datos. Simplemente contiene los datos de población del Padrón. Están sacados del INE. Concretamente de [aquí](http://www.ine.es/nomen2/ficheros.do) Así que los datos en realidad provienen del **[Nomenclátor: Población del Padrón Continuo por Unidad Poblacional](http://www.ine.es/nomen2/index.do)**. Me bajé los ficheros de los años 2010 a 2017, ambos incluidos.

Información
===========

El INE tiene información detallada [aquí](http://www.ine.es/nomen2/Metodologia.do).

del diseño de registro. Para entenderlo yo algún día uso los datos de mi pueblo.

Mi pueblo
=========

Mi pueblo es Pancrudo, en la provincia de Teruel. Es mi pueblo, pero para el INE es un municipio compuesto de 4 núcleos: Pancrudo, Portalrubio, Cervera del rincón y Cuevas de Portalrubio. Veamos sus registros para 2017

    #> Warning: package 'tidyverse' was built under R version 3.4.3
    #> -- Attaching packages --------------------------------------------------------------- tidyverse 1.2.1 --
    #> v ggplot2 2.2.1.9000     v purrr   0.2.4     
    #> v tibble  1.4.2          v dplyr   0.7.4     
    #> v tidyr   0.8.0          v stringr 1.2.0     
    #> v readr   1.1.1          v forcats 0.2.0
    #> Warning: package 'tidyr' was built under R version 3.4.3
    #> Warning: package 'purrr' was built under R version 3.4.3
    #> Warning: package 'dplyr' was built under R version 3.4.2
    #> -- Conflicts ------------------------------------------------------------------ tidyverse_conflicts() --
    #> x dplyr::filter() masks stats::filter()
    #> x dplyr::lag()    masks stats::lag()

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

Como veis, mi pueblo tenía en 2017 77 habitantes, pero el municipio de Pancrudo tenía 119 (somos grandes!!)

Para entender la codificación lo mejor es ir al diseño de registro, pero en [este articulo de la Wiki](https://es.wikipedia.org/wiki/Entidad_singular_de_poblaci%C3%B3n) lo explican bien.

Example
-------

Para cargar el fichero con los datos basta con:

``` r
# devtools::install_github("perezp44/spanishRpoblacion")
library(spanishRpoblacion)
df <- INE_padron_10_17
```

Para ver los registros de pancrudo en 2017:

``` r
library(tidyverse)
Pancrudo <- INE_padron_10_17 %>% 
            filter(anyo == "2017") %>% 
            filter(Provincia == 44) %>% 
            filter(Municipio == 177)
```

Para ver los municipios en 2017 (hay 8.124):

``` r
#- municipios en 2017 (EC=00, ES=00 y NUC=00)
muni_2017 <- INE_padron_10_17 %>% filter(anyo == "2017")  %>%     
             filter(str_detect(Code_unidad_poblacional, "(000000)$"))
```

Para ver como ha variado el número de municipios en 2010-2017:

``` r
#- nº de municipios por año
aa <- INE_padron_10_17 %>% 
      filter(str_detect(Code_unidad_poblacional, "(000000)$")) %>%
      group_by(anyo) %>% 
      summarise(NN = n())
```

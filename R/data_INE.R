#------------------------------ This file documents INE datasets

#' Poblacion PADRON INE (SPAIN) 2010-2017
#'
#' Poblacion PADRON INE (SPAIN) 2010-2017
#' 1.219.020 registros
#' 13 variables
#'
#' @source \url{http://www.ine.es}
#'
#' @format A data frame with 1.219.020 registros and 13 variables:
#' \itemize{
#'   \item X1: Microdato original
#'   \item anyo: periodo
#'   \item Code_Unidad_poblacional: Pancrudo = 44177000000
#'   \item Nombre_Unidad_poblacional: PANCRUDO
#'   \item Poblacion_Total: Poblacion Total
#'   \item Poblacion_H: Hombres
#'   \item Poblacion_M: Mujeres
#'   \item Provincia: PANCRUDO esta en Teruel = 44
#'   \item Municipio: Codigo INE municipio Pancrudo = 177
#'   \item Entidad_colectiva: codigo de 2 digitos
#'   \item Entidad_singular: codigo de 2 digitos
#'   \item Nucleo_o_diseminado: codigo de 2 digitos
#'   \item TIPO:    Municipios, Entidad Singular, Nucleos ....
#' }
#'
#' @examples
#' \dontrun{
#'  df <- INE_padron_10_17
#' }
#'
"INE_padron_10_17"



#' Poblacion de MUNICIPIOS PADRON INE (SPAIN) 2010-2017
#'
#' Poblacion de los MUNICIPIOS: PADRON INE (SPAIN) 2010-2017
#' 64.948 registros
#' 8 variables
#'
#' @source \url{http://www.ine.es}
#'
#' @format A data frame with 64.948 registros and 8 variables:
#' \itemize{
#'   \item INECodMuni: PANCRUDO = 44177
#'   \item Code_Unidad_poblacional: Pancrudo = 44177000000
#'   \item Nombre_Unidad_poblacional: PANCRUDO
#'   \item Provincia: PANCRUDO esta en Teruel = 44
#'   \item Municipio: Codigo INE municipio Pancrudo = 177
#'   \item anyo: periodo
#'   \item Poblacion_Total: Poblacion Total
#'   \item Poblacion_H: Hombres
#'   \item Poblacion_M: Mujeres
#' }
#'
#' @examples
#' \dontrun{
#'  df <- INE_padron_10_17_muni
#'  df_2017 <- df %>% filter(anyo == 2017)
#' }
#'
"INE_padron_10_17_muni"



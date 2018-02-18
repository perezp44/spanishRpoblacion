#------------------------------ This file documents INE datasets

#' Poblacion para Municipios PADRON INE (SPAIN) 1996 y 1998-2017
#'
#' Poblacion (Total, Mujeres y Hombres) para municipios españoles
#' Procede del PADRON INE (SPAIN)
#' 170.334 registros
#' 11 variables
#'
#' @source \url{http://www.ine.es}
#'
#' @format A data frame with 170.334 registros and 11 variables:
#' \itemize{
#'   \item INECodProv: Codigo provincial del INE (Teruel = 44)
#'   \item INECodMuni: Codigo de 5 digitos que identifica los municipios (Pancrudo = 44177)
#'   \item NombreMuni: Nombre del municipio
#'   \item Pob_T: Poblacion Total
#'   \item Pob_H: Hombres
#'   \item Pob_M: Mujeres
#'   \item anyo: periodo (de 2010 a 2017)
#'   \item INECodCCAA: Codigo INE para la C.A., 2 digitos
#'   \item NombreCCAA: Nombre de la C.A.
#'   \item NombreProv: Nombre de la provincia
#'   \item Capital_prov: 1 = municipio capital de provincia
#' }
#'
#' @examples
#' \dontrun{
#'  df <- INE_padron_muni_96_17
#' }
#'
"INE_padron_muni_96_17"



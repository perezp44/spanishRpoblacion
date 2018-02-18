#------------------------------ This file documents INE datasets

#' Poblacion para Entidades PADRON INE (SPAIN) 2010-2017
#'
#' Poblacion (Total, Mujeres y Hombres) para entidades españolas, 2010-2017
#' Procede del PADRON INE (SPAIN)
#' 1.219.020 registros
#' 16 variables
#'
#' @source \url{http://www.ine.es}
#'
#' @format A data frame with 1.219.020 registros and 16 variables:
#' \itemize{
#'   \item INECodProv: Codigo provincial del INE (Teruel = 44)
#'   \item INECodMuni: Codigo de 5 digitos que identifica los municipios (Pancrudo = 44177)
#'   \item Code_Unidad_poblacional: Codigo de entidades, 11 digitos (Pancrudo = 44177000000)
#'   \item Nombre_Unidad_poblacional: PANCRUDO (estaba en mayusculas)
#'   \item anyo: periodo (de 2010 a 2017)
#'   \item Poblacion_Total: Poblacion Total
#'   \item Poblacion_H: Hombres
#'   \item Poblacion_M: Mujeres
#'   \item TIPO: Municipios, Entidad Singular, Nucleos ....
#'   \item Entidad_colectiva: codigo de 2 digitos
#'   \item Entidad_singular: codigo de 2 digitos
#'   \item Nucleo_o_diseminado: codigo de 2 digitos
#'   \item INECodCCAA: Codigo INE para la C.A., 2 digitos
#'   \item NombreCCAA: Nombre de la C.A.
#'   \item NombreProv: Nombre de la provincia
#'   \item Capital_prov: 1 = municipio capital de provincia
#' }
#'
#' @examples
#' \dontrun{
#'  df <- INE_padron_entidades_10_17
#' }
#'
"INE_padron_entidades_10_17"



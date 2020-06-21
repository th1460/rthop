#' @title From CEP to geographic coordinate system
#'
#' @description Transforme CEP in geographic coordinate system using viacep.com.br
#'
#' @param cep Number with 8 digits
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

cep2coo <- function(cep){

  if(nchar(cep) == 8){

    res <- httr::GET(glue::glue("viacep.com.br/ws/{cep}/json/")) %>% httr::content()

    if(grepl("erro", names(res)) %>% any){

      stop("CEP no exist")

    } else {

      address <- glue::glue("{res$logradouro}, {res$bairro},
                      {res$localidade}, Brasil")

      coo <- photon::geocode(iconv(address,
                                   from = "UTF-8",
                                   to = "ASCII//TRANSLIT"),
                             limit = 1)[,c("lat", "lon")] %>%
        as_tibble() %>%
        bind_cols(cep = cep) %>%
        select(cep, lat, lon)

    }

  } else {

    stop("Invalid number of digits")

  }

  return(coo)

}

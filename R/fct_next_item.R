#' next_item
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
next_item <- function(
    df,
    aplicados,
    theta_inicial,
    theta
){

  itens_disponiveis <- as.matrix(df[!(df$item %in% aplicados) ,c('item','a', names(df[,grepl('^b', names(df))]), 'c')])

  if(is.null(aplicados)) {
    theta <- theta_inicial
  }

  next_item <- catIrt::itChoose(
    left_par = itens_disponiveis,
    mod = "grm",
    numb = 1,
    n.select = 1,
    cat_theta = theta,
    select = "UW-FI",
    at = "theta"
  )

  next_item <- next_item$params[[1]]

  print(next_item)

  return(next_item)
}

#' cria_mod_minimo
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
cria_mod_minimo <- function(
    mod,
    df,
    theta_inicial
){
  mod$aplicados <- numeric(0)
  mod$padrao <- rep(NA, nrow(df))
  mod$resp_itens <- rep(NA, nrow(df))
  mod$theta_hist <- theta_inicial
  mod$se_hist <- 1
  mod$hist_resp_time <- Sys.time()

  return(mod)
}

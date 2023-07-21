#' atualiza_r_cat
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
atualiza_r_cat <- function(
    mod,
    it_select,
    input,
    df,
    modelo_cat
){

  # hora de resposta
  mod$hist_resp_time <- c(mod$hist_resp_time, Sys.time())

  # resposta_provisorio <- as.numeric(input)

  # atualizar o padrão de resposta -----
  mod$padrao[df$item == it_select] <- as.numeric(input)

  # mod$resp_itens[df$item == it_select] <- as.numeric(input)

  # atualizar os itens aplicados -----
  mod$aplicados <- c(mod$aplicados, it_select)

  # calcular o theta -----
  theta_prov <- mirt::fscores(modelo_cat, response.pattern = mod$padrao)

  # atualizar o theta_cat ----
  mod$theta <- data.frame(theta_prov)$F1

  # atualizar o histórico do theta ----
  mod$theta_hist <- c(mod$theta_hist, mod$theta)

  # erro ----
  mod$se_atual <- data.frame(theta_prov)$SE_F1

  # atualizar o histórico do erro ----
  mod$se_hist <- c(mod$se_hist, mod$se_atual)

  # escore final
  # mod$escore <- mod$theta

  return(
    mod
  )
}

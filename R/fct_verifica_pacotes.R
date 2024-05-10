#' verifica_pacotes
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
verificar_e_instalar <- function(
    pacotes = c("catIrt", "config", "crayon", "golem", "mirt", "mirtCAT", "shiny", "shinydashboard", "shinyjs", "usethis"),
    versoes_minimas = c(NA, "0.3.1", NA, "0.3.5", NA, NA, "1.7.3", NA, NA, NA)
  ) {
  for (i in seq_along(pacotes)) {
    pacote <- pacotes[i]
    versao_minima <- versoes_minimas[i]
    message(sprintf("Verificando pacote %s...", pacote))
    pacote_instalado <- require(pacote, character.only = TRUE, quietly = TRUE)

    # Verifica se a versão instalada é menor que a versão mínima requerida
    if (!pacote_instalado || (!is.na(versao_minima) && packageVersion(pacote) < as.package_version(versao_minima))) {
      message(sprintf("Instalando ou atualizando %s...", pacote))
      install.packages(pacote, dependencies = TRUE)
      library(pacote, character.only = TRUE)
      message(crayon::green("✔"), "Instalado")
    } else {
      message(crayon::green("✔"), "Instalado")
    }
  }
}

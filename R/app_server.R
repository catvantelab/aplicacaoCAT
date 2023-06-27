#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  # Inicializa o r como lista de valores reativos

  r <- reactiveValues()

  # Lista de configurações gerais da CAT
  r$config <- list(
    # define o theta inicial
    theta_inicial = 0,
    # Critérios de parada:
    ## Erro
    erro = 0.4,
    ## Delta Theta
    delta.theta = NULL
  )

  #' ATENÇÃO!!!
  #' EVITE ALTERAR ESSE ARQUIVO A PARTIR DESTE PONTO

  # Lista agregadora das funções para cada tipo de input
  r$carrossel_itens <- list(
    radio = function(df, it, ns){

      cat <- unname(unlist(df[df$item == it, grepl('^cat', names(df))]))

      cat <- cat[!is.na(cat)]
      div(
        radioButtons(
          ns('alternativas'),
          label = df$enunciado[df$item == it],
          choiceNames = c(1:length(cat)),
          choiceValues = 0:(length(cat) - 1),
          selected = character(0)
        ),
        class = 'item'
      )

    }
  )



  # APP UI ------------------------------------------------------------------

  output$ui <- renderUI({
    mod_apresentacao_ui("apresentacao_1")
  })


# SERVERS -----------------------------------------------------------------

  mod_apresentacao_server("apresentacao_1", r)
  mod_cat_server("cat_1", r)

}

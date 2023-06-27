#' apresentacao UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_apresentacao_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns('ui'))
  )
}

#' apresentacao Server Functions
#'
#' @noRd
mod_apresentacao_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$ui <- renderUI({
      tagList(
        h1('Título do seu instrumento'), # preencha aqui o título do seu instrumento
        p('Descrição do instrumento'), # preencha aqui a instrução do seu instrumento.
        # Caso queira, adicione outras informaçoes aqui
        actionButton(
          ns('continuar'),
          'Continuar'
        )
      )
    })

    #' ATENÇÃO!!!
    #' EVITE ALTERAR ESSE ARQUIVO A PARTIR DESTE PONTO

    observeEvent(input$continuar, {
      output$ui <- renderUI(mod_cat_ui("cat_1"))
    })
  })
}

## To be copied in the UI
#

## To be copied in the server
#

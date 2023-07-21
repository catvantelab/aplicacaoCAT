#' devolutiva UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_devolutiva_ui <- function(id){
  ns <- NS(id)
  # Faça as alterações de texto aqui
  tagList(
    h1('Obrigado por responder'),
    p('seu nível de habilidade é:'),
    uiOutput(ns('escore'))
  )
}

#' devolutiva Server Functions
#'
#' @noRd
mod_devolutiva_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$escore <- renderUI({
      # caso queira alterar a escala do theta, altere aqui
      h2(round(r$cat$theta, 2))
    })

  })
}

## To be copied in the UI
#

## To be copied in the server
#

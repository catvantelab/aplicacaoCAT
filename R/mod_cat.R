#' cat UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_cat_ui <- function(id){
  ns <- NS(id)
  tagList(

  )
}

#' cat Server Functions
#'
#' @noRd
mod_cat_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Interface do usuário -----
    output$ui <- renderUI({
      tagList(
        uiOutput(ns('botao_alternativas')),
        br(),
        shinyjs::disabled(
          actionButton(
            ns('responder'),
            'Responder',
            onclick = 'document.getElementById(this.id).disabled = true'
          )
        )
      )
    })

    output$botao_alternativas <- renderUI({
      r$carrossel_itens[['radio']](
        df_instrumento,
        next_item(
          df = df_instrumento,
          aplicados = r$cat$aplicados,
          theta_inicial = r$config$theta_inicial,
          theta = r$cat$theta
        ),
        ns
      )
    })

    # Lógica para habilitar o botão de responder
    observe({
      if(!is.null(input$alternativas)) {
        if(input$alternativas != ''){
          shinyjs::enable('responder')
        }
      }
    })


    # Funcionamento da CAT ----------------------------------------------------

    # Qual o próximo item a ser selecionado?

    # Ao responder os itens
    observeEvent(input$responder,{
      req(r)

      # Caso seja o primeiro item
      if(is.null(r$cat$aplicados)){
        r$cat <- cria_mod_minimo(
          mod = r$cat,
          df = df_instrumento,
          theta_inicial = r$config$theta_inicial
        )
      }
      # Calcula o escore e atualiza o mod para as próximas perguntas
      r$cat <- atualiza_r_cat(
        mod = r$cat,
        it_select = next_item(
          df = df_instrumento,
          aplicados = r$cat$aplicados,
          theta_inicial = r$config$theta_inicial,
          theta = r$cat$theta
        ),
        input = input$alternativas,
        df = df_instrumento,
        modelo_cat = mod_total[[nome_cat]]
      )

      # Verifica se a CAT chegou ao fim
      r[[nome_cat]]$fim <- fim_cat(
        # criterios
        criterio = list(
          erro = r$config$erro,
          max.itens = nrow(df)
        ),
        erro = r[[nome_cat]]$se_atual,
        aplicados = r[[nome_cat]]$aplicados
      )

      # Caso tenha chego, toma as ações necessárias

      if(r[[nome_cat]]$fim$fim){

        # Próximo fator
        r$i <- r$i + 1

        output$ui <- renderUI(r$instrumentos_mods[[r$i]])
      }

    })

  })

}

## To be copied in the UI
#

## To be copied in the server
#

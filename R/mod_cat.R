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
    uiOutput(ns('ui'))
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

    observe({
      isolate({
        r$it_select <- next_item(
          df = df_instrumento,
          aplicados = r$cat$aplicados,
          theta_inicial = r$config$theta_inicial,
          theta = r$cat$theta
        )
      })
    })

    output$botao_alternativas <- renderUI({
      r$carrossel_itens[['radio']](
        df_instrumento,
        r$it_select,
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
        it_select = r$it_select,
        input = input$alternativas,
        df = df_instrumento,
        modelo_cat = mirt_model
      )

      # Verifica se a CAT chegou ao fim
      r$cat$fim <- fim_cat(
        # criterios
        criterio = list(
          erro = r$config$erro,
          max.itens = nrow(df_instrumento)
        ),
        erro = r$cat$se_atual,
        aplicados = r$cat$aplicados
      )

      # Caso tenha chego, toma as ações necessárias

      if(!r$cat$fim$fim){

        isolate(
          r$it_select <- next_item(
            df = df_instrumento,
            aplicados = r$cat$aplicados,
            theta_inicial = r$config$theta_inicial,
            theta = r$cat$theta
          )
        )


        output$botao_alternativas <- renderUI({
          r$carrossel_itens[['radio']](
            df_instrumento,
            r$it_select,
            ns
          )
        })

      } else {

        output$ui <- renderUI(mod_devolutiva_ui("devolutiva_1"))
      }

    })

  })

}

## To be copied in the UI
#

## To be copied in the server
#

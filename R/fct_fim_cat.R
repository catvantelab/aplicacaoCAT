#' fim_cat
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
fim_cat <- function(
    # criterios
  criterio = list(
    erro = NULL,
    delta.theta = NULL,
    hypo = NULL,
    hyper = NULL,
    info = NULL,
    # quantidade máxima de itens aplicados
    max.itens = NULL,
    # quantidade mínima de itens aplicados
    min.itens = NULL,
    # quantidade fixa de itens
    itens.fixo = NULL,
    # limite de tempo
    tempo_limite = NULL
  ),
  # valores na iteração
  # erro padrão
  erro = NULL,
  # diferença entre o theta atual e o anterior
  delta.theta = NULL,
  # máxima informação no banco
  info = NULL,
  # quantidade de itens aplicados
  aplicados = NULL,
  # variação do erro (predito ou observado)
  delta.erro = NULL,
  # histórico do tempo de resposta
  hist_resp_time = NULL
){

  # se não informar o mínimo de itens no critério, ele será 0
  if(is.null(criterio$min.itens))
    criterio$min.itens <- 0

  convergencia <- FALSE
  tempo_estourado <- FALSE

  if(!is.null(criterio$erro) & is.null(erro))
    stop('Favor informar o erro')

  if(!is.null(criterio$delta.theta) & is.null(delta.theta))
    stop('Favor informar o delta theta')

  if(!(is.null(criterio$hypo) | is.null(criterio$hyper)) & is.null(delta.erro))
    stop('Favor informar o delta erro')

  if((!is.null(criterio$hypo) | !is.null(criterio$hyper)) & is.null(criterio$erro))
    stop('Favor informar o erro')

  if(!is.null(criterio$hypo) & is.null(criterio$hyper))
    stop('Favor informar o hyper')

  if(is.null(criterio$hypo) & !is.null(criterio$hyper))
    stop('Favor informar o hypo')

  if(!is.null(criterio$info) & is.null(info))
    stop('Favor informar a máxima informação no banco')

  # if(!is.null(criterio$delta.erro) & is.null(delta.erro))
  #   stop('Favor informar o delta erro')

  if(!is.null(aplicados) & (is.null(criterio$max.itens) & is.null(criterio$itens.fixo)))
    warning('Informou os itens aplicados, mas não há critério relacionado')

  if(!is.null(criterio$itens.fixo) & (!is.null(criterio$max.itens) | !is.null(criterio$delta.theta) | !is.null(criterio$erro) | !is.null(criterio$delta.erro) | !is.null(criterio$info) | !is.null(criterio$hypo)))
    stop('Escolha um critério, porque se há um número fixo de itens, esse prevalece')

  fim <- FALSE

  if(!is.null(criterio$erro))
    fim <- fim | erro <= criterio$erro

  if(!is.null(criterio$info))
    fim <- fim | info < criterio$info

  if(!is.null(criterio$delta.theta))
    fim <- fim | abs(delta.theta) <= criterio$delta.theta

  # if(!is.null(criterio$delta.erro))
  #   fim <- fim | abs(delta.erro) <= criterio$delta.erro

  if(!is.null(criterio$hyper)){
    fim <- (abs(delta.erro) <= criterio$hyper) & erro <= criterio$erro
    fim <- fim | abs(delta.erro) <= criterio$hypo
  }

  if (length(aplicados) < criterio$min.itens)
    fim <- FALSE

  if (fim)
    convergencia <- TRUE

  if (!is.null(criterio$max.itens)){
    if(is.null(aplicados))
      stop('Favor informar a quantidade de itens aplicados')
    fim <- fim | length(aplicados) >= criterio$max.itens
  }

  if (!is.null(criterio$itens.fixo)){
    if(is.null(aplicados))
      stop('Favor informar a quantidade de itens aplicados')
    fim <- length(aplicados) == criterio$itens.fixo
    if(fim)
      convergencia <- TRUE
  }

  # Convergência por tempo
  if(!is.null(hist_resp_time)){

    if(is.null(criterio$tempo_limite)) stop('Favor informar o tempo limite')

    tempo_estourado <- difftime(
      hist_resp_time[length(hist_resp_time)],
      hist_resp_time[1],
      units = c('mins')
    ) >= criterio$tempo_limite

    # Estabelece que o fim é verdadeiro pois respondeu acima do limite de tempo
    if(tempo_estourado){
      fim <- TRUE
    }
  }

  fim <- list(
    fim = fim,
    convergencia = convergencia,
    tempo_estourado = tempo_estourado
  )
  return(fim)
}

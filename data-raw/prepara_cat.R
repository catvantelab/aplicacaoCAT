#'-----------------------------------------------------------------------------
#' PROJETO: CATvante
#'
#' OBJETIVO: Gerar os insumos necessários para que
#'
#' PRODUTO: bases de dados
#'
#' AUTOR: Araê Cainã
#'
#' DATA DE CRIACAO: 31/10/2022
#'
#' DATA DE MODIFICACAO:
#'
#' MODIFICACOES:
#'-----------------------------------------------------------------------------

# Carrega funções --------------------------------------------------------

#' ATENÇÃO!!!
#' Rode essa linha antes de começar
source("R/fct_verifica_requisitos_df_instrumento.R", chdir=TRUE)
source("R/fct_verifica_pacotes.R", chdir=TRUE)

# Pacotes -----------------------------------------------------------------

#' Rode o código abaixo para verificar se os pacotes necessários estão instalados
verificar_e_instalar()

# Lê o df_instrumento -----------------------------------------------------

#' Certifique-se que ele contém os seguintes requisitos:
#'  1. Uma coluna chamada `item` com valores numéricos não repetidos.
#'    Esse é o número do item que o algoritmo de escolha de item irá usar como referência
#'  2. Uma coluna chamada `enuncionado`, com valores em texto
#'    Essa coluna terá o enunciado do item que será apresentado ao sujeito
#'  3. Ao menos duas colunas chamada `cat`, numeradas com as categorias de resposta
#'    Essas são as colunas que irão conter o texto dos itens. Elas precisam estar numeradas
#'    de 1 até o número de categorias. Se são 5 categorias, fica cat1, cat2, cat3, cat4 e cat5
#'  4. Uma coluna com o parâmetro `a`, de mesmo nome
#'  5. Para cada mudança de categoria de resposta, uma coluna chamada `b`.
#'    Este modelo de cat usa o Modelo de Respostas Graduais de Samejima.
#'    Para cada mudança em categoria de resposta, precisa conter uma coluna correspondente.
#'    Se são 5 categorias, são 4 mudanças. É preciso que hajam as colunas b1, b2, b3 e b4
#'  6. Uma coluna com o parâmetro `c`, de mesmo nome.
df_instrumento <- readxl::read_xlsx(
  'data-raw/df_instrumento.xlsx'
)


# Verifica requisitos da base de dados ------------------------------------

#' Rode a função abaixo para verificar os requisitos citados acima.
#' Se estiver tudo certo, ela mesmo irá salvar a base de dados.
verifica_requisitos_df_instrumento(df_instrumento)

#' Pronto!
#' Caso queira alterar a apresentação da CAT, vá até o arquivo app_server.R

rstudioapi::navigateToFile("R/mod_apresentacao.R")

#' verifica_requisitos_df_instrumento
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
verifica_requisitos_df_instrumento <- function(df_instrumento){
  require(crayon)

  # Verifica se a coluna 'item' está correta
  if ("item" %in% colnames(df_instrumento)) {
    if (is.numeric(df_instrumento$item) && length(unique(df_instrumento$item)) == nrow(df_instrumento)) {
      cat(crayon::green("✔"), "A coluna 'item' atende aos requisitos\n")
    } else {
      stop("A coluna 'item' não atende aos requisitos. Verifique se a coluna 'item' possui valores numéricos e não repetidos\n")
    }
  } else {
    stop("A coluna 'item' não está presente na base de dados. Ela deve conter valores únicos e numéricos\n")
  }

  # Verifica se a coluna 'enunciado' está correta
  if ("enunciado" %in% colnames(df_instrumento)) {
    if (is.character(df_instrumento$enunciado)) {
      cat(crayon::green("✔"), "A coluna 'enunciado' atende aos requisitos\n")
    } else {
      stop("A coluna 'enunciado' não contém valores do tipo string (ou texto)\n")
    }
  } else {
    stop("A coluna 'enunciado' não está presente na base de dados. Ela deve conter somente valores do tipo string (ou texto)\n")
  }

  colunas_categoria <- grep("^cat\\d+$", colnames(df_instrumento), value = TRUE)
  colunas_b <- grep("^b\\d+$", colnames(df_instrumento), value = TRUE)

  if (length(colunas_categoria) > 0) {
    if (sum(grepl("^cat\\d+$", colunas_categoria)) >= 2) {
      if (length(colunas_b) == length(colunas_categoria) - 1) {
        if (sum(colnames(df_instrumento) == "a") == 1 && sum(colnames(df_instrumento) == "c") == 1) {
          cat(crayon::green("✔"), "As colunas de categorias e parâmetros atendem aos requisitos\n")
        } else {
          stop("Deve haver exatamente uma coluna 'a' e uma coluna 'c' na base de dados\n")
        }

        colunas_categoria_num <- as.integer(sub("^cat", "", colunas_categoria))
        if (!all(colunas_categoria_num == seq_along(colunas_categoria_num))) {
          stop("As colunas de categoria não estão em ordem crescente começando do 1\n")
        }

        colunas_b_num <- as.integer(sub("^b", "", colunas_b))
        if (!all(colunas_b_num == seq_along(colunas_b_num))) {
          stop("As colunas 'b' não estão em ordem crescente começando do 1\n")
        }

        for(i in c("a", colunas_b, "c")){
          if(!is.numeric(df_instrumento[[i]])){
            stop('A coluna', i, 'não contêm valores numéricos\n')
          } else {
            cat(crayon::green("✔"), 'A coluna', i, 'atende aos requisitos\n')
          }
        }

      } else {
        stop("O número de colunas que começam com 'b' não está correto. É necessário que haja uma coluna para cada mudança de categoria\n")
      }
    } else {
      stop("Não existem pelo menos duas colunas iniciando com 'cat'\n")
    }
  } else {
    stop("As colunas de categoria não estão presentes na base de dados\n")
  }

  usethis::use_data(
    df_instrumento,
    overwrite = TRUE
  )

  cat(crayon::green("✔"), "Base de dados carregada com sucesso\n")
}

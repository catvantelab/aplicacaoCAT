# Primeiro passo

O primeiro passo será copiar o repositório disponível no link https://github.com/catvantelab/aplicacaoCAT. Para usuários menos familiarizados com o github, é possível baixar o repositório ao clicar no botão “<> Code” e em seguida escolher a opção “Download ZIP”. Com o repositório em seu computador, é possível prosseguir com a implementação da CAT. 

# Segundo Passo
O segundo passo é abrir o projeto. Clique no arquivo aplicacaoCAT.Rproj, na pasta principal do repositório. Note que para isso é preciso ter o R instalado e o RStudio. O R é a linguagem, enquanto o RStudio é o programa que viabiliza a utilização do R. Caso não tenha instalado qualquer um dos recursos acima, siga o tutorial disponível em https://posit.co/download/rstudio-desktop/.

# Terceiro Passo
O terceiro passo é alterar o arquivo data-raw/df_instrumento.xlsx. Esse arquivo contém informações sobre os itens, em especial o texto do item (na coluna “enunciado”), as categorias de resposta (nas colunas que começam com “cat”) e os parâmetros dos itens (nas colunas “a”, todas que começam com “b” e na coluna “c”). Altere o arquivo com as informações corretas do seu teste e salve o arquivo com o mesmo nome. 

# Quarto Passo
O quarto passo é abrir o arquivo data-raw/prepara_cat.R dentro do RStudio e rodar as linhas de código para verificar se o arquivo data-raw/df_instrumento.xlsx foi preenchido corretamente. Ao rodar a função verifica_requisitos_df_instrumento(df_instrumento) no arquivo R/prepara_cat.R você irá receber uma mensagem no console dizendo se tudo correu bem. Caso haja algum erro de preenchimento, leia o console para saber qual parte está errada. 

# Quinto Passo
O quinto passo é abrir o arquivo R/mod_apresentacao.R. É nesse arquivo que está a página inicial da sua CAT. Altera o título da sua CAT na linha 25, e descreva as instruções do teste na linha 26. Para usuários familiarizados com shiny, é possível incluir mais informações, como imagens ou novos parágrafos.

# Sexto Passo
O sexto passo é a configuração da sua CAT. Para isso, abra o arquivo R/app_server.R. Esse é o arquivo que implementa a lógica de funcionamento da sua aplicação como um todo. Nele, existe um objeto chamado de r$config (linha 15). Esse objeto é responsável por dizer ao algoritmo da CAT os critérios de escolha de novos itens e de parada. Defina o teta inicial na linha 17, o critério de parada por SE na linha 20 e, se desejar, o critério de parada por delta teta na linha 22. 

# Sétimo Passo
O sétimo passo é alterar a devolutiva. Este modelo de implementação de uma CAT oferece como padrão uma devolutiva que o escore da pessoa é apresentada em escala de teta. Caso queira alterar a devolutiva, abra o arquivo R/mod_devolutiva.R. Ele está dividido em duas partes, interface de usuário (UI) e servidor (server). Na interface do usuário é possível incluir mais informações para os respondentes. Altere as linhas 14 e 15 para personalizar sua devolutiva. É possível incluir mais textos, imagens ou gráficos/tabelas para tornar a devolutiva mais útil para o sujeito. Caso queira converter o teta em outra escala (e.g., percentil), faça isso no servidor (linha 29). O objeto r$cat$theta armazena o último escore da pessoa, e pode ser facilmente manipulado. Usuários mais experientes podem usar esse valor para produzir algum gráfico. Caso seja esse o caso, será preciso alterar a interface do usuário para receber um gráfico.

# Oitavo Passo
O oitavo passo é checar se a CAT está sendo gerada corretamente. Para rodar sua CAT localmente (i.e., no seu computador), abra o arquivo dev/run_dev.R, selecione todas as linhas e rode o código. Isso irá garantir que o sistema será iniciado da maneira correta. Caso haja algum problema, a origem do erro será apresentada para o usuário no console.

# Nono Passo
O novo e último passo é publicar sua CAT para que outras pessoas tenham acesso por meio de um link de internet. Primeiramente é necessário ter clareza que existem diversos serviços de hospedagem em nuvem, cada serviço de hospedagem utiliza de uma tecnologia diferente e sua aplicação deve ser configurada de acordo com as especificações dos servidores. Visando facilitar a publicação da CAT, o modelo está configurado para ser publicado nos servidores do shinyapps, serviço de hospedagem gerido pela Posit, empresa que também mantém o RStudio. Caso não tenha conta no serviço, basta acessar o link https://www.shinyapps.io/ e criar uma conta gratuita. Para conseguir conectar os servidores do shinyapps pelo seu computador e publicar a aplicação, é preciso configurar os tokens de acesso. Clique na opção Account/Tokens da barra lateral da área logada do shinyapps, clique em Add Token, copie o código apresentado e rode no seu RStudio. Isso irá permitir publicar a aplicação. Em seguida, abra no RStudio o arquivo app.R, que está na pasta raiz do RProj, e clique no botão de publicação e em seguida clique em Publish Application. Caso tudo dê certo, ao final da publicação sua CAT abrirá em uma janela do seu navegador, e estará pronta para uso.

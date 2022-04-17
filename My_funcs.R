#Imprime textos e funÃ§Ãµes matemÃ¡ticas em plots vazios

plotex <- function(x, n){
  print(attributes(plotex))
  plot.new()
  text(.5, .5, 
       x, 
       cex = n)
}

attr(plotex, "comment") <- "A funÃ§Ã£o 'plotex' gera a visualizaÃ§Ã£o de um texto ou expressÃ£o diretamente na janela 'Plots' do R. Os dois argumentos utilizados aqui sÃ£o 'x', que Ã© a expressÃ£o impressa na janela, e 'n' que Ã© o tamanho do texto utilizado."


#Ponto de corte do cÃ¡lcio

pcut <- function(x){
  print(attributes(pcut))
  require(fBasics)
  y <- mean(x)+5*stdev(x)
  print("Seu ponto de corte (mÃ©dia + 5x o desvio padrÃ£o) Ã©: ")
  return(y)
}

attr(pcut, "comment") <- "Retorna o ponto de corte para o ensaio de cÃ¡lcio."

#Salva base plots

bsave <- function(pryr, path, w, h, r){
  require(pryr)
  tiff(filename = path, 
       width = w, 
       height = h, 
       units = "in",
       res = r)
  pryr
  dev.off()
}

attr(bsave, "comment") <- "Salva grÃ¡ficos armazenados como cÃ³digo em pryr. Para salvar o grÃ¡fico, atribua o cÃ³digo gerador a um pryr da seguinte maneira 'p1.pryr %<a-% {'cÃ³digo aqui'}'"

#Cria distribuiÃ§Ã£o normal com possibilidade de colorir parte da dist

normal_area <- function(mean = 0, sd = 1, lb, ub, acolor = "lightgray", ...) {
  x <- seq(mean - 3 * sd, mean + 3 * sd, length = 100) 
  
  if (missing(lb)) {
    lb <- min(x)
  }
  if (missing(ub)) {
    ub <- max(x)
  }
  
  x2 <- seq(lb, ub, length = 100)    
  plot(x, dnorm(x, mean, sd), type = "n", ylab = "")
  
  y <- dnorm(x2, mean, sd)
  polygon(c(lb, x2, ub), c(0, y, 0), col = acolor)
  lines(x, dnorm(x, mean, sd), type = "l", ...)
}

attr(normal_area, "comment") <- "Cria distribuiÃ§Ã£o normal com possibilidade de colorir parte da distribuiÃ§Ã£o. Ã‰ necessÃ¡rio usar a funÃ§Ã£o 'text()' para inserir alguma legenda ao grÃ¡fico"

#Analisa planilhas de cÃ¡lcio com apenas um comando

cadata <- function(filepath){
  require(reshape2)
  require(pryr)
  require(tidyverse)
  require(fBasics)
  require(bayestestR)
  df <- readxl::read_excel(filepath)
  df <- drop_na(df)
  totcells <- ncol(df)-1
  exptime <- as.numeric(max(df[,1]))
  a <- melt(df[1:30,2:(ncol(df))], id.vars = 0)
  baseline <- mean(a$value)
  cut <- mean(a$value)+5*stdev(a$value)
  gmelt <- melt(df, id.vars = 1)
  plot(x = gmelt$`Time (sec)`, 
       y = gmelt$value, 
       col = gmelt$variable,
       ylab = "F340/380", 
       xlab = "Time (sec)")
  condit <- function(){
    btm <- readline(prompt = "Bottom limit (insert value): ")
    btm <- as.integer(btm)
    top <- readline(prompt = "Upper limit (insert value): ")
    top <- as.integer(top)
    df <<- df[df$`Time (sec)` >= btm,]
    df <<- df[df$`Time (sec)` <= top,]}
  condit()
  dmelt <- melt(df, id.vars = 1)
  p1.pryr %<a-% {plot(x = dmelt$`Time (sec)`, 
                      y = dmelt$value, 
                      col = dmelt$variable,
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  dcut <- dmelt[dmelt$value >= cut,]
  p2.pryr %<a-% {plot(x = dcut$`Time (sec)`, 
                      y = dcut$value, 
                      col = dcut$variable, 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  dbase <- dmelt[dmelt$value <= cut,]
  p3.pryr %<a-% {plot(x = dbase$`Time (sec)`, 
                      y = dbase$value, 
                      col = dbase$variable, 
                      ylim = c(0, 1.5), 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  nmbresp <- length(unique(dcut$variable))
  percresp <- ((nmbresp*100)/totcells)
  avg <- dmelt %>% 
    group_by(`Time (sec)`) %>%
    summarise(sd = stdev(value), 
              len = mean(value))
  p4.pryr %<a-% {plot(avg$len ~ avg$`Time (sec)`, 
                      col = "lightblue", 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")
    lines(avg$len ~ avg$`Time (sec)`)}
  percmax <- ((max(avg$len)*100)/baseline)
  aucmed <- area_under_curve(x = avg$`Time (sec)`, y = avg$len)
  results <- data.frame(format(totcells, digits = 6),
                        format(nmbresp, digits = 6), 
                        format(exptime, digits = 6), 
                        format(baseline, digits = 5), 
                        format(cut, digits = 5), 
                        format(percresp, digits = 6), 
                        format(percmax, digits = 6), 
                        format(aucmed, digits = 6))
  names(results) <- c("total_cells",
                      "responsive_cells",
                      "exp_duration_sec", 
                      "baseline_intensity", 
                      "cutpoint",
                      "percent_responsive",
                      "percent_increase_ca", 
                      "area_under_curve")
  results <- melt(results, id.vars = 0)
  par(mfrow = c(2,2))
  p1.pryr
  p2.pryr
  p4.pryr
  p3.pryr
  par(mfrow = c(1,1))
  results
}

attr(cadata, "comment") <- "Analisa ensaios de cÃ¡lcio. Basta inserir o caminho do arquivo na funÃ§Ã£o e entÃ£o informar o intervalo de tempo a ser analisado."

catoplus <- function(filepath, fullrun = NULL){
  require(reshape2)
  require(pryr)
  require(tidyverse)
  require(fBasics)
  require(bayestestR)
  df <- readxl::read_excel(filepath)
  df <- drop_na(df)
  totcells <- ncol(df)-1
  exptime <- as.numeric(max(df[,1]))
  a <- melt(df[1:30,2:(ncol(df))], id.vars = 0)
  baseline <- mean(a$value)
  cut <- mean(a$value)+5*stdev(a$value)
  if (is.null(fullrun)){
  gmelt <- melt(df, id.vars = 1)
  plot(x = gmelt$`Time (sec)`, 
       y = gmelt$value, 
       col = gmelt$variable,
       ylab = "F340/380", 
       xlab = "Time (sec)")
  btm <- readline(prompt = "Bottom limit (insert value): ")
  btm <- as.integer(btm)
  top <- readline(prompt = "Upper limit (insert value): ")
  top <- as.integer(top)
  df <- df[df$`Time (sec)` >= btm,]
  df <- df[df$`Time (sec)` <= top,]
  dmelt <- melt(df, id.vars = 1)
  p1.pryr %<a-% {plot(x = dmelt$`Time (sec)`, 
                      y = dmelt$value, 
                      col = dmelt$variable,
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  dcut <- dmelt[dmelt$value >= cut,]
  p2.pryr %<a-% {plot(x = dcut$`Time (sec)`, 
                      y = dcut$value, 
                      col = dcut$variable, 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  dbase <- dmelt[dmelt$value <= cut,]
  p3.pryr %<a-% {plot(x = dbase$`Time (sec)`, 
                      y = dbase$value, 
                      col = dbase$variable, 
                      ylim = c(0, 1.5), 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  nmbresp <- length(unique(dcut$variable))
  percresp <- ((nmbresp*100)/totcells)
  avg <- dmelt %>% 
    group_by(`Time (sec)`) %>%
    summarise(sd = stdev(value), 
              len = mean(value))
  p4.pryr %<a-% {plot(avg$len ~ avg$`Time (sec)`, 
                      col = "lightblue", 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")
    lines(avg$len ~ avg$`Time (sec)`)}
  percmax <- ((max(avg$len)*100)/baseline)
  aucmed <- area_under_curve(x = avg$`Time (sec)`, y = avg$len)
  results <- data.frame(format(totcells, digits = 6),
                        format(nmbresp, digits = 6), 
                        format(exptime, digits = 6), 
                        format(baseline, digits = 5), 
                        format(cut, digits = 5), 
                        format(percresp, digits = 6), 
                        format(percmax, digits = 6), 
                        format(aucmed, digits = 6))
  names(results) <- c("total_cells",
                      "responsive_cells",
                      "exp_duration_sec", 
                      "baseline_intensity", 
                      "cutpoint",
                      "percent_responsive",
                      "percent_increase_ca", 
                      "area_under_curve")
  results <- melt(results, id.vars = 0)
  par(mfrow = c(2,2))
  p1.pryr
  p2.pryr
  p4.pryr
  p3.pryr
  par(mfrow = c(1,1))
  results}
  else{
  dmelt <- melt(df, id.vars = 1)
  p1.pryr %<a-% {plot(x = dmelt$`Time (sec)`, 
                      y = dmelt$value, 
                      col = dmelt$variable,
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  dcut <- dmelt[dmelt$value >= cut,]
  p2.pryr %<a-% {plot(x = dcut$`Time (sec)`, 
                      y = dcut$value, 
                      col = dcut$variable, 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  dbase <- dmelt[dmelt$value <= cut,]
  p3.pryr %<a-% {plot(x = dbase$`Time (sec)`, 
                      y = dbase$value, 
                      col = dbase$variable, 
                      ylim = c(0, 1.5), 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")}
  nmbresp <- length(unique(dcut$variable))
  percresp <- ((nmbresp*100)/totcells)
  avg <- dmelt %>% 
    group_by(`Time (sec)`) %>%
    summarise(sd = stdev(value), 
              len = mean(value))
  p4.pryr %<a-% {plot(avg$len ~ avg$`Time (sec)`, 
                      col = "lightblue", 
                      ylab = "F340/380", 
                      xlab = "Time (sec)")
    lines(avg$len ~ avg$`Time (sec)`)}
  percmax <- ((max(avg$len)*100)/baseline)
  aucmed <- area_under_curve(x = avg$`Time (sec)`, y = avg$len)
  results <- data.frame(format(totcells, digits = 6),
                        format(nmbresp, digits = 6), 
                        format(exptime, digits = 6), 
                        format(baseline, digits = 5), 
                        format(cut, digits = 5), 
                        format(percresp, digits = 6), 
                        format(percmax, digits = 6), 
                        format(aucmed, digits = 6))
  names(results) <- c("total_cells",
                      "responsive_cells",
                      "exp_duration_sec", 
                      "baseline_intensity", 
                      "cutpoint",
                      "percent_responsive",
                      "percent_increase_ca", 
                      "area_under_curve")
  results <- melt(results, id.vars = 0)
  par(mfrow = c(2,2))
  p1.pryr
  p2.pryr
  p4.pryr
  p3.pryr
  par(mfrow = c(1,1))
  results}
}

attr(catoplus, "comment") <- "Analisa ensaios de cÃ¡lcio. Basta inserir o caminho do arquivo na funÃ§Ã£o e entÃ£o informar o intervalo de tempo a ser analisado. Se TRUE for fornecido para fullrun, o programa analisarÃ¡ toda a corrida."

#Gera ggplots simples de maneira ágil

df <- readxl::read_excel("C:\\Users\\hercu\\Downloads\\TABELA_DE_DADOS.xlsx")

ggbar <- function(data, y, x, fill="white", title="", ylab="", xlab="", texsize=10, errorbar=NULL){
  df <- data
  x <- df[,x]
  y <- df[,y]
  rbar <- cbind(x, y)
  df <- rbar
  rbar <- rbar %>% group_by(rbar[,1]) %>% summarise(value = mean(rbar[,2]), sd = sd(rbar[,2]))
  colnames(rbar) <- c("grupo", "value", "sd")
  if(is.null(errorbar)){
    ggplot(data = df, aes(x = df[,1], y = df[,2])) +
      geom_bar(stat = "summary", 
             fun = "mean", 
             fill = fill, 
             col = I("black")) + 
    theme(panel.background = element_blank(), 
          axis.line.y = element_line("black", size = .25), 
          axis.line.x = element_line("black", size = .25), 
          axis.text.x=element_text(size=10), 
          axis.text.y=element_text(size=10), 
          plot.title = element_text(size = texsize+2), 
          axis.title.y = element_text(size = texsize),
          axis.title.x = element_text(size = texsize)) + 
    geom_point(position = position_jitter(0.1),
               size = 2, 
               shape = 15) + 
    labs(title = title, y = ylab, 
         x = xlab)}
  else{
    ggplot(data = df, aes(x = df[,1], y = df[,2])) +
      geom_bar(stat = "summary", 
               fun = "mean", 
               fill = fill, 
               col = I("black")) + 
      theme(panel.background = element_blank(), 
            axis.line.y = element_line("black", size = .25), 
            axis.line.x = element_line("black", size = .25), 
            axis.text.x=element_text(size=10), 
            axis.text.y=element_text(size=10), 
            plot.title = element_text(size = texsize+2), 
            axis.title.y = element_text(size = texsize),
            axis.title.x = element_text(size = texsize)) + 
      geom_point(position = position_jitter(0.1),
                 size = 2, 
                 shape = 15) + 
      labs(title = title, y = ylab, 
           x = xlab) +
      geom_errorbar(data = rbar,
                      aes(x = grupo, 
                          y = value, 
                          ymin = value - sd,
                          ymax = value + sd), 
                      width = 0.2)}
}

ggbar(data = df, 
      y = "IDADE", 
      x = "GRUPO", 
      fill = "lightblue", 
      title = "Ggawesome!", 
      ylab = "Idade", 
      xlab = "Grupo",
      texsize = 13,
      errorbar = T)

ggbox <- function(data, y, x, fill="white", title="", ylab="", xlab="", texsize=10){
  df <- data
  x <- df[,x]
  y <- df[,y]
  rbar <- cbind(x, y)
  df <- rbar
  rbar <- rbar %>% group_by(rbar[,1]) %>% summarise(value = mean(rbar[,2]), sd = sd(rbar[,2]))
  colnames(rbar) <- c("grupo", "value", "sd")
  ggplot(data = df, aes(x = df[,1], y = df[,2])) +
    geom_boxplot(data = df, aes(x = df[,1], y = df[,2]), fill = fill, outlier.shape = NA) + 
    stat_boxplot(geom ='errorbar', width = .2) +
    theme(panel.background = element_blank(), 
          axis.line.y = element_line("black", size = .25),
          axis.line.x = element_line("black", size = .25), 
          axis.text.x=element_text(size=10), 
          axis.text.y=element_text(size=10), 
          plot.title = element_text(size = texsize+2), 
          axis.title.y = element_text(size = texsize),
          axis.title.x = element_text(size = texsize)) + 
    geom_point(position = position_jitter(0.1),
               size = 2, 
               shape = 15) + 
    labs(title = title, 
         y = ylab, 
         x = xlab)
}

ggbox(data = df, 
      y = "IDADE", 
      x = "GRUPO", 
      fill = "lightblue", 
      title = "Ggawesome!", 
      ylab = "Idade", 
      xlab = "Grupo",
      texsize = 13)

attr(ggbox, "comment") <- "Gera um boxplot simples com o ggplot2"

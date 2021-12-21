#Dicas:

##Para rodar um comando, selecione a(s) linha(s) e aperte cmd (ou ctrl) + enter

##[1] Esquerda superior (aqui) -> editor de código

##[2] Esquerda inferior -> console (resultados dos comandos não gráficos)

##[3] Direita inferior -> visualizador (gráficos, ajuda, navegador...)

##[4] Direita superior -> ambiente/histórico  (planilhas, objetos, comandos...)

##Ampliar a janela: [1] = ctrl+shift+1 / [2] = ctrl+shift+2 / 
##                  [3] = ctrl+shift+3 / [4] = ctrl+shift+4

##Está com dúvidas em algum comando ou função? Rode o código:
##?nome_do_comando (sem jogo da velha)

#Instalar pacotes

install.packages("xlsx")
install.packages("vioplot")
install.packages("psych")
install.packages("gplots")
install.packages("pastecs")
install.packages("fBasics")
install.packages("skimr")
install.packages("ExPanDaR")
install.packages("GGally")
install.packages("rstatix")
install.packages("pwr")
install.packages("effsize")

#Importar pacotes a serem utilizados

library(psych)
library(dplyr, warn.conflicts = FALSE)
library("RColorBrewer")
library(gplots)
library(pastecs)
library(fBasics)
library(skimr)
library(ExPanDaR)
library(corrplot)
library(vioplot)
library(ggplot2)
library(GGally)
library(xlsx)
library(reshape2)
library(rstatix)
library(kableExtra)
library(pwr)
library(effsize)

#Cálculo de poder estatístico e tamanho amostral

##IMPORTANTE: pwr.anova.test() exige pacote 'pwr'

##ANOVA

av <- pwr.anova.test(k = 4, ###Número de grupos 
                     n = NULL, ###Número de observações (tamanho amostral) 
                     f = 0.5, ###Tamanho de efeito f 
                     sig.level = 0.05, ###alfa (prob. de falso positivo) 
                     power = .95) ###1 - beta (1 - prob. de falso negativo)

av

plot.power.htest(av)

##Teste t

#IMPORTANTE: cohen.d() exige pacote 'effsize'

##Calcular o tamanho de effeito Cohen D

cohen.d(df$Controle, df$Tratamento_II)

##Calcular o teste t utilizando o tamanho de efeito calculado

#IMPORTANTE: pwr.t.test() exige pacote 'pwr'

tt <- pwr.t.test(n = NULL, ###Número de observações (tamanho amostral)
                 d = 1.5, ###Tamanho de efeito d
                 sig.level = 0.05, ###alfa (prob. de falso positivo)
                 power = .95, ###1 - beta (1 - prob. de falso negativo)
                 type = "two.sample", ###Duas amostras, não pareadas
                 alternative = "two.sided") ###Valor é maior ou menor

tt

plot.power.htest(tt)

#Importar a planilha a ser analisada

##IMPORTANTE: substituir o caminho do arquivo para a planilha desejada

df <- readxl::read_excel('/Users/herculesrezendefreitas/Downloads/R projects/Results_model.xlsx')

#Visualizar uma parte dos dados no console (janela abaixo)

df

#Criar uma "tabela" diretamente no R (exemplo abaixo)

##Primeiro, crie os vetores com valores de cada coluna

Controle <- c(95.2618454,
              92.13381555,
              97.84615385,
              98.8475457,
              90.50704942,
              87.3190025,
              90.77281689,
              89.36114184,
              95.00712872,
              97.33020831,
              90.82158097,
              89.81937974,
              97.75434077,
              98.18070701)

Positivo <- c(0.67114094,
              0.101112235,
              0.343642612,
              1.66768746,
              0.622325536,
              0.663438837,
              1.29611535,
              1.755941115,
              0.567796205,
              0.823841307,
              1.050682223,
              0.896305131,
              1.319383896,
              1.893025442)

Tratamento_I <- c(97.9301423,
                  88.39160839,
                  96.36363636,
                  92.36734536,
                  88.26833944,
                  97.31882091,
                  87.79539853,
                  95.4437578,
                  87.45515398,
                  91.02689562,
                  92.61273772,
                  91.05310723,
                  91.24194591,
                  92.28904403)

Tratamento_II <- c(76.4720108,
                   75.64001264,
                   76.49453384,
                   75.33877758,
                   75.45820278,
                   78.72481174,
                   76.70422698,
                   76.20735939,
                   76.08017052,
                   75.49445089,
                   76.4321343,
                   78.485223,
                   75.94288458,
                   76.91323186)

##Depois, crie um dataframe com os vetores acima

df2 <- data.frame(Controle, Positivo, Tratamento_I, Tratamento_II)

##Visualizar uma parte dos dados no console (janela abaixo)

df2

##Criar uma tabela formatada

##IMPORTANTE: kbl() exige pacote 'kableExtra'

db <- df2 ###Cria um objeto (db) com as mesmas propriedades de df2

kbl(db) ###Cria um objeto kbl() a partir de db

db %>%
  kbl(caption = "Experimento modelo I") %>%
  kable_classic(full_width = F, html_font = "Cambria") ###Cria a tabela

##Compare df e df2

##IMPORTANTE: glimpse() exige pacote 'dplyr'

glimpse(df)
glimpse(df2)

#Visualizar a estatística descritiva de cada coluna (básico)

##RESULTADOS: Mínimo, 
##            1º quartil,
##            Mediana, 
##            Média, 
##            3º quartil, 
##            Máximo

summary(df)

#Visualizar a estatística descritiva de cada coluna (médio)

##IMPORTANTE: exige pacote 'pastecs'

##RESULTADOS: Número de valores, 
##            Número de valores nulos,
##            Número de valores ausentes, 
##            Mínimo, 
##            Máximo, 
##            Intervalo mínimo-máximo, 
##            Soma, 
##            Mediana, 
##            Média, 
##            Erro padrão da média, 
##            Intervalo de confiança 95%,
##            Variância, 
##            Desvio padrão, 
##            Coeficiente de variação

stat.desc(df)

#Visualizar a estatística descritiva de cada coluna com histogramas (avançado)

##IMPORTANTE: exige pacote 'skimr'

##RESULTADOS: Número de linhas, 
##            Número de colunas,
##            Tipo de dado nas colunas (ex.: numérico), 
##            Variáveis agrupadas (categóricos), 
##            Nome da variável, 
##            Valores faltando, 
##            Taxa de completude (indica ausência de valores),
##            Média,
##            Desvio padrão (sd), 
##            Percentil 0 (p0),
##            Percentil 25 (p25),
##            Percentil 50 (p50),
##            Percentil 75 (p75),
##            Percentil 100 (p100),
##            Histogramas

skim(df)

#Visualizar a estatística descritiva de cada coluna (avançado)

##IMPORTANTE: exige pacote 'psych'

##RESULTADOS: Variáveis, 
##            Número de observações,
##            Média, 
##            Desvio padrão (sd), 
##            Mediana, 
##            Média truncada, 
##            Desvio mediano absoluto (mad), 
##            Mínimo, 
##            Máximo, 
##            Intervalo mínimo-máximo, 
##            Enviesamento (skew), 
##            Curtose (kurtosis), 
##            Erro padrão da média (se)

describe(df)

#Exportar resultados como planilha excel (ou outros formatos)

##IMPORTANTE: exige pacote 'xlsx' para o formato excel

##Primeiro, crie um objeto com o resultado desejado

tabela <- describe(df)

##Segundo, escreva:
##                  o comando write.table
##                  o nome do objeto x (tabela)
##                  o caminho do arquivo file (onde ele será salvo e o nome)

write.xlsx(x = tabela, 
            file = '/Users/herculesrezendefreitas/Downloads/stats.xlsx')

#Criar gráfico de boxplots (básico)

boxplot(df$Controle, 
        df$Positivo, 
        df$Tratamento_I, 
        df$Tratamento_II, 
        col = "lightblue")

#Criar mais de um gráfico simultaneamente (médio)

##Determine quantas linhas e colunas terá sua janela

par(mfrow = c(4, 1)) ###Quatro linhas, uma coluna

##Plote o gráfico

plot(density(df$Controle), ###Gráfico de densidade
     col = 'green', ###Cor desejada para o gráfico
     xlim = c(0, 100), ###Limites do eixo x
     main = "Controle", ###Título
     xlab = "Intensidade") ###Legenda do eixo x

plot(density(df$Tratamento_I), 
     col = 'blue', 
     xlim = c(0, 100), 
     main = "Tratamento_I", 
     xlab = "Intensidade")

plot(density(df$Tratamento_II), 
     col = 'orange', 
     xlim = c(0, 100), 
     main = "Tratamento_II", 
     xlab = "Intensidade")

plot(density(df$Positivo), 
     col = 'red', 
     xlim = c(0, 100), 
     main = "Positivo", 
     xlab = "Intensidade")

#Sobrepor elementos em gráficos (médio-avançado)

hist(df$Controle, ###Histograma
     freq = F, ###Sem contagem de frequências
     xlim = c(0,100), ###Limites do eixo x
     col = "white", ###Cor desejada para o gráfico
     main = "Controle", ###Título
     xlab = "Intensidade") ###Legenda do eixo x
lines(density((df$Controle)), ###Gráfico de densidade
      col = "green", ###Cor desejada para o gráfico
      lwd = 2) ###Espessura da linha
lines(x = c(mean(df$Controle), mean(df$Controle)), ###xy da Linha
      y = c(mean(df$Controle), 0), ###xy da Linha
      col = "green", ###Cor desejada para o gráfico
      lty = 2, ###Tipo de linha (pontilhada)
      lwd = 2) ###Espessura da linha
lines(x = c(min(df$Controle), min(df$Controle)), ###xy da Linha
      y = c(min(df$Controle), 0), ###xy da Linha
      col = "green", ###Cor desejada para o gráfico
      lty = 2, ###Tipo de linha (pontilhada)
      lwd = 2) ###Espessura da linha

hist(df$Tratamento_I, 
     freq = F, 
     xlim = c(0,100), 
     col = "white", 
     main = "Tratamento_I", 
     xlab = "Intensidade")
lines(density((df$Tratamento_I)), 
      col = "blue", 
      lwd = 2)
lines(x = c(mean(df$Tratamento_I), mean(df$Tratamento_I)), 
      y = c(mean(df$Tratamento_I), 0), 
      col = "blue", 
      lty = 2, 
      lwd = 2)
lines(x = c(min(df$Tratamento_I), min(df$Tratamento_I)), 
      y = c(min(df$Tratamento_I), 0), 
      col = "blue", 
      lty = 2, 
      lwd = 2)

hist(df$Tratamento_II, 
     freq = F, 
     xlim = c(0,100), 
     col = "white", 
     main = "Tratamento_II", 
     xlab = "Intensidade")
lines(density((df$Tratamento_II)), 
      col = "orange", 
      lwd = 2)
lines(x = c(mean(df$Tratamento_II), mean(df$Tratamento_II)), 
      y = c(mean(df$Tratamento_II), 0), 
      col = "orange", 
      lty = 2, 
      lwd = 2)
lines(x = c(min(df$Tratamento_II), min(df$Tratamento_II)), 
      y = c(min(df$Tratamento_II), 0), 
      col = "orange", 
      lty = 2, 
      lwd = 2)

hist(df$Positivo, 
     freq = F, 
     xlim = c(0,100), 
     col = "white", 
     main = "Positivo", 
     xlab = "Intensidade")
lines(density((df$Positivo)), 
      col = "red", 
      lwd = 2)
lines(x = c(mean(df$Positivo), mean(df$Positivo)), 
      y = c(mean(df$Positivo), 0), 
      col = "red", 
      lty = 2, 
      lwd = 2)
lines(x = c(min(df$Positivo), min(df$Positivo)), 
      y = c(min(df$Positivo), 0), 
      col = "red", 
      lty = 2, 
      lwd = 2)

##Lembre-se de inserir o comando para apenas uma linha e coluna

par(mfrow = c(1, 1)) ###Quatro linhas, uma coluna

#Criar gráficos com ggplot (avançado)

##Se o dado estiver no formato wide (nosso exemplo), use a função 'melt'

##IMPORTANTE: exige pacote 'reshape2'

dt <- melt(df)

##Visualize e compare o formato wide (df) com o formato long (dt):

df ###Aqui primeiro
dt ###Depois aqui

##O pacote ggplot2 possui as seguintes propriedades:
##                                                  Origem dos dados, 
##                                                  Estética, 
##                                                  Representação geométrica, 
##                                                  Estatística, 
##                                                  Coordenadas espaciais, 
##                                                  Rótulos, 
##                                                  Temas, 

##Crie o gráfico (de barras com pontos individuais)

ggplot(dt, aes(x = variable, 
               y = value)) + ###Cria o gráfico
  geom_bar(stat = "summary", 
           fun = "mean", 
           fill = "lightblue") + ###Determina o tipo (barras)
  geom_point(position = position_jitter(0.1), 
             size = 1, 
             shape = 21) + ###Adiciona pontos individuais
  theme(panel.background = element_blank(), 
        axis.line.y = element_line("black", size = .25), 
        axis.line.x = element_line("black", size = .25)) ###Muda o tema

##Método alternativo (gráfico com pontos e erro)

##Transforme as variáveis categóricas em fatores

dt$variable <- as.factor(dt$variable)

##Utilize group_by() e summarise() para obter média e desvio padrão

##IMPORTANTE: group_by() exige pacote 'dplyr'
##IMPORTANTE: summarise() exige pacote 'plyr'

dtt <- dt %>% 
  group_by(variable) %>% 
  summarise(sd = sd(value, na.rm = TRUE), 
            len = mean(value))

##Crie o gráfico (de barras com pontos e erro)

ggplot(dt, aes(x = variable, 
                y = value)) + ###Cria o gráfico
  geom_bar(stat = "summary", 
           fun = "mean", 
           fill = "lightblue") + ###Determina o tipo (barras)
  geom_jitter(position = position_jitter(0.2), 
              color = "black", 
              size = 1, 
              shape = 21) + ###Adiciona pontos individuais
  theme(panel.background = element_blank(), 
        axis.line.y = element_line("black", size = .25), 
        axis.line.x = element_line("black", size = .25)) + ###Muda o tema
  geom_errorbar(aes(x = variable, 
                    y = len, 
                    ymin = len-sd, 
                    ymax = len+sd), 
                data = dtt, 
                width = 0.2) ###Adiciona as barras de erro

#Realizar análise de variância (ANOVA) e testes de hipóteses

##Utilizando dt (df depois de passar por melt()):

##1. Verifique se seus categóricos são fatores utilizando a função glimpse()

glimpse(dt)

##2. Busque por outliers nos dados usando identify_outliers()

##IMPORTANTE: identify_outliers() e group_by() exigem pacote 'rstatix'

dt %>% 
  group_by(variable) %>% 
  identify_outliers(value)

##3. Avalie a normalidade dos dados com shapiro_test()

##IMPORTANTE: shapiroTest() exige pacote 'fBasics'

shapiroTest(x = df$Controle)
shapiroTest(x = df$Positivo)
shapiroTest(x = df$Tratamento_I)
shapiroTest(x = df$Tratamento_II)

##4. Construa o modelo de análise da variância com aov()

##IMPORTANTE: aov() exige pacote 'stats'

##Componentes: aov(variável dependente ~ variável independente)

res.aov <- aov(dt$value ~ dt$variable) ###Cria o modelo

summary(res.aov) ###Apresenta os resultados

##5. Realize um teste post-hoc de Tukey com TukeyHSD()

##IMPORTANTE: TukeyHSD() exige pacote 'stats'

TukeyHSD(res.aov, conf.level = .99) ###Testa e apresenta os resultados

##6. Realize um teste t entre duas amostras independentes

##IMPORTANTE: t.test() exige pacote 'stats'

t.test(df$Controle, df$Positivo) ###Testa e apresenta os resultados
t.test(df$Controle, df$Tratamento_I) ###Testa e apresenta os resultados
t.test(df$Controle, df$Tratamento_II) ###Testa e apresenta os resultados

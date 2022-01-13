<div style="display: inline_block"><br>
  <img align="center" alt="fig1" height="120" width="120" src="https://avatars.githubusercontent.com/u/91353422?v=4">
</div>


------------------------------------------------------------------------------------------------------------------------------
## heRcules: um repositório de scripts R anotados em Português

> O repositório te ajudou? Você pode nos ajudar:
> 
> 1. Compartilhando em redes sociais
> 
>     <div> <a href="https://www.linkedin.com/" target="_blank"><img src="https://img.shields.io/badge/-LinkedIn-%230077B5?style=for-the-badge&logo=linkedin&logoColor=white" target="_blank"></a> <a href="https://www.instagram.com/" target="_blank"><img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white" target="_blank"></a> <a href="https://twitter.com/?lang=en" target="_blank"><img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" target="_blank"></a> <a href="https://web.whatsapp.com/" target="_blank"><img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" target="_blank"></a> <a href="https://web.telegram.org/" target="_blank"><img src="https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white" target="_blank"></a> </div>
> <p><p/>
> 
> 2. Fazendo uma doação para um projeto social. Sugerimos o "Brasil sem fome"
> 
>     <div> <a href="https://www.brasilsemfome.org.br/" target="_blank"><img src="https://user-images.strikinglycdn.com/res/hrscywv4p/image/upload/c_limit,fl_lossy,h_300,w_300,f_auto,q_100/3737110/622911_969507.png" target="_blank"></a> </div>
> 
> 3. Comprando um café :coffee: ou um chá :tea: para o Hércules (cógigo PIX no QR code)
> 
>     <img align="center" alt="fig3" height="160" width="120" src="https://user-images.githubusercontent.com/91353422/149412962-eca4b520-4671-4e2b-b009-d01c740263d9.jpeg"/>

**1. Repositório de scripts R para a análise de dados em Ciências Biológicas e da Saúde. Meu objetivo aqui é:**

- Fornecer scripts R anotados para facilitar a transição de usuários de softwares pagos;

- Desenvolver protocolos gerais passo a passo para a análise de dados científicos;

- Fornecer arquivos de markdown estruturados para facilitar o relatório da análise de dados;

### **Aprendendo o básico da linguagem R**

**1. Ao usuário completamente inexperiente no uso da linguagem R, recomenda-se a leitura do guia:**

- [“Introdução ao R"](https://vanderleidebastiani.github.io/tutoriais/Introducao_ao_R.html), de Vanderlei Júlio Debastiani (@vanderleidebastiani)

**2. Se quiser saber como instalar o R (e o ambiente de desenvolvimento RStudio), acesse:**

- [Ciência de Dados em R](https://livro.curso-r.com/1-1-instalacao-do-r.html), de Athos Damiani, Beatriz Milz, Caio Lente, Daniel Falbel, Fernando Correa, Julio Trecenti, Nicole Luduvice e William Amorim (@Curso-R)

### **Componentes do modelo I**



>**ATENÇÃO!** Se for utilizar o modelo em uma publicação, cite:

>Freitas, H.R. heRcules: A repository for annotated R scripts in Portuguese for scientific data analysis. SciELO Preprints. 2022. Version 1. doi: 10.1590/SciELOPreprints.3389

>[Clique aqui para acessar](https://doi.org/10.1590/SciELOPreprints.3389)



**1. Importando dados de planilhas**

- O caso mais habitual para pesquisas em Biociências é a importação de dados contidos em planilhas, normalmente salvas no formato '.xlsx'. Para esse tipo de documento, basta que o pesquisador execute o seguinte código:

```R
df <- readxl::read_excel("caminho/do/arquivo/no/computador/nomedoarquivo.xlsx")
```

- No caso acima, o comando importará para o ambiente R a primeira aba da planilha e atribuirá ao objeto “df” as informações contidas nela. O uso de "df", porém, é apenas uma convenção. Os dados poderiam ser importados da mesma maneira para um objeto chamado "obj", por exemplo. Uma visão parcial do objeto criado pode ser obtida através do comando "df" (ou "obj"), mas é possível interagir de forma mais completa (típico de planilhas) através do comando "View(df)" (sem as aspas).

```R
View(df)
```

<img align="center" width="430" alt="fig2" src="https://user-images.githubusercontent.com/91353422/149055241-8d88e999-11d5-47e8-83f2-84c47ef69488.png">

- É importante destacar que a maioria das funções utilizadas no presente modelo dependem da instalação de pacotes, como é habitual em R. Para instalar e importar um determinado pacote no seu ambiente R, utilizam-se os seguintes comandos:

```R
install.packages("nomedopacote") #Aguardar a instalação e, então, executar:

library(nomedopacote)
```

**2. Estimativas de poder estatístico e tamanho amostral**

- Um dos elementos mais importantes do planejamento de experimentos é a estimativa de tamanho amostral. Uma leitura mais detalhada sobre o assunto pode ser encontrada no texto ["Poder do teste e tamanho do efeito"](https://biostatistics-uem.github.io/Bio/aula9/effectsize.html), de Felipe Barletta e Isolde Previdelli (@Biostatistics-UEM).

- Utilizando o [pacote "pwr"](https://github.com/heliosdrm/pwr), as estimativas de *tamanho amostral* e *poder estatístico* para a análise de variância (ANOVA) podem ser realizadas utilizando o mesmo código, sendo apenas necessário substituir o valor desejado por “NULL". Veja o exemplo abaixo para a estimativa de tamanho amostral:

```R
av <- pwr.anova.test(k = 4,             #Número de grupos 
                     n = NULL,          #Número de observações (tamanho amostral) 
                     f = 0.5,           #Tamanho de efeito f 
                     sig.level = 0.05,  #alfa (prob. de falso positivo) 
                     power = .95)       #1 - beta (1 - prob. de falso negativo)

av
```

```
Balanced one-way analysis of variance power calculation 

              k = 4
              n = 18.18244
              f = 0.5
      sig.level = 0.05
          power = 0.95

NOTE: n is number in each group
```

- O mesmo pacote, "pwr", pode ser utilizado para gerar um gráfico da estimativa "av", que permite visualizar a variação de poder estatístico em função do tamanho amostral:

```R
plot.power.htest(av)
```

![Rplot](https://user-images.githubusercontent.com/91353422/149058642-1f695017-31d4-414b-9634-d9e065337664.png)

- Os parâmetros acima também podem ser obtidos para outros testes, como os testes *t* [(veja mais detalhes no artigo)](https://doi.org/10.1590/SciELOPreprints.3389).

**3. Estimativa de tamanho de efeito**

- O pacote “pwr” oferece, ainda, a possibilidade de se estimar o tamanho de efeito sem a necessidade de calculadoras ou aplicativos externos. No presente modelo, pode-se observar um exemplo da análise de tamanho de efeito (d de Cohen) entre os grupos “Controle” e “Tratamento_II” (ver tabela em "Importando dados de planilhas"), que resulta em um d = 5.96, com intervalo de confiança entre 4.15 e 7.78.

```R
cohen.d(df$Controle, df$Tratamento_II) #Onde "df" contém os dados e "$" indexa as colunas (ex.: "Controle")
```

```
Cohen's d

d estimate: 5.969867 (large)
95 percent confidence interval:
   lower    upper 
4.155318 7.784415 
```

- O tamanho de efeito f (f de Cohen) também pode ser calculado em R. Para tanto, o [pacote "effectsize"](https://easystats.github.io/effectsize/) fornece a fórmula "cohens_f()". Para o modelo I (ver tabela em "Importando dados de planilhas"), primeiro é necessária uma modificação no formato como os dados são apresentados (*wide-to-long*). Por enquanto, vamos apenas imaginar que os valores numéricos estão armazenados na palavra "value" e os nomes de cada grupo estão armazenados na palavra "variable". Veja:

```R
aav <- aov(value ~ variable, data = dt) #Criação de um modelo de ANOVA (no objeto "aav") com os dados do modelo

cohens_f(aav)                           #Cálculo do tamanho de efeito para ANOVA (f de Cohen)
```

```
Effect Size for ANOVA

Parameter | Cohen's f |            95% CI
-----------------------------------------
variable  |     14.56 | [12.18,      Inf]
```

- Antes de prosseguir, é importante ressaltar que todos os modelos e estimativas estatísticas precisam ser satisfatoriamente compreendidos pelo pesquisador antes de sua aplicação a algum dado experimental. Aos interessados, sugere-se a leitura dos textos ["Orientações sobre Cálculo Amostral"](http://calculoamostral.bauru.usp.br/calculoamostral/orienta%C3%A7ao.php), de José Roberto Pereira Lauris e ["Testes de hipóteses"](https://www.fcav.unesp.br/Home/departamentos/cienciasexatas/EUCLIDESBRAGAMALHEIROS/materialdidatico/anoletivo-2017/1semestre/pos-graduacao/processamentodedados/TESTES%20DE%20HIP%C3%93TESES.pdf), de Euclides Braga Malheiros.

**4. Estatística descritiva**

- Existe uma multitude de pacotes disponíveis para a obtenção de estatísticas descritivas sobre seu conjunto de dados. Aqui, serão apresentados recursos capazes de suprir grande parte das demandas em Ciências Biológicas e da Saúde. Com o tempo, é possível ao pesquisador criar as próprias funções (e pacotes), personalizando ainda mais o seu ambiente R. A primeira função, "summary()", pertence ao ambiente nativo (Base) do R e fornece os seguintes resultados (quando aplicada ao modelo I):

```
RESULTADOS: Mínimo, 
            1º quartil,
            Mediana, 
            Média, 
            3º quartil, 
            Máximo
```

- Veja, abaixo, um exemplo do uso de "summary()":

```R
summary(df) #Lembre-se, "df" é o nome dado ao objeto que armazena as informações do modelo I
```

```
Controle        Positivo         Tratamento_I    Tratamento_II  
Min.   :87.32   Min.   :0.1011   Min.   :87.46   Min.   :75.34  
1st Qu.:90.57   1st Qu.:0.6326   1st Qu.:89.05   1st Qu.:75.72  
Median :93.57   Median :0.8601   Median :91.77   Median :76.32  
Mean   :93.64   Mean   :0.9766   Mean   :92.11   Mean   :76.46  
3rd Qu.:97.65   3rd Qu.:1.3136   3rd Qu.:94.74   3rd Qu.:76.65  
Max.   :98.85   Max.   :1.8930   Max.   :97.93   Max.   :78.72 
```

- A segunda função, "stat.desc()", depende do [pacote "pastecs"](https://github.com/phgrosjean/pastecs) (veja como importar um pacote em "Importando dados de planilhas") e fornece os seguintes resultados:

```
RESULTADOS: Número de valores, 
            Número de valores nulos,
            Número de valores ausentes, 
            Mínimo, 
            Máximo, 
            Intervalo mínimo-máximo, 
            Soma, 
            Mediana, 
            Média, 
            Erro padrão da média, 
            Intervalo de confiança 95%,
            Variância, 
            Desvio padrão, 
            Coeficiente de variação
```

- Veja, abaixo, um exemplo do uso de "stat.desc()":

```R
stat.desc(df) #Lembre-se, "df" é o nome dado ao objeto que armazena as informações do modelo I
```

```
             Controle     Positivo   Tratamento_I  Tratamento_II
nbr.val      1.400000e+01 14.0000000 1.400000e+01  1.400000e+01
nbr.null     0.000000e+00  0.0000000 0.000000e+00  0.000000e+00
nbr.na       0.000000e+00  0.0000000 0.000000e+00  0.000000e+00
min          8.731900e+01  0.1011122 8.745515e+01  7.533878e+01
max          9.884755e+01  1.8930254 9.793014e+01  7.872481e+01
range        1.152854e+01  1.7919132 1.047499e+01  3.386034e+00
sum          1.310963e+03 13.6724383 1.289558e+03  1.070388e+03
median       9.357047e+01  0.8600732 9.176549e+01  7.631975e+01
mean         9.364019e+01  0.9766027 9.211128e+01  7.645629e+01
SE.mean      1.052423e+00  0.1450803 9.448416e-01  2.757487e-01
CI.mean.0.95 2.273622e+00  0.3134270 2.041206e+00  5.957188e-01
var          1.550632e+01  0.2946763 1.249816e+01  1.064523e+00
std.dev      3.937806e+00  0.5428409 3.535274e+00  1.031757e+00
coef.var     4.205252e-02  0.5558462 3.838046e-02  1.349473e-02
```

- A proxima função, "skim()", do [pacote "skimr"](https://github.com/ropensci/skimr), é interessante pois gera um conjunto valioso de informações estatísticas sobre os dados e ainda fornece um "histograma", que confere uma perspectiva inical sobre a distribuição dos valores. São os resultados:

```
RESULTADOS: Número de linhas, 
            Número de colunas,
            Tipo de dado nas colunas (ex.: numérico), 
            Variáveis agrupadas (categóricos), 
            Nome da variável, 
            Valores faltando, 
            Taxa de completude (indica ausência de valores),
            Média,
            Desvio padrão (sd), 
            Percentil 0 (p0),
            Percentil 25 (p25),
            Percentil 50 (p50),
            Percentil 75 (p75),
            Percentil 100 (p100),
            Histogramas
```

- Veja, abaixo, um exemplo do uso de "skim()":

```R
skim(df) #Lembre-se, "df" é o nome dado ao objeto que armazena as informações do modelo I
```

```
── Data Summary ────────────────────────
                           Values
Name                       df    
Number of rows             14    
Number of columns          4     
_______________________          
Column type frequency:           
  numeric                  4     
________________________         
Group variables            None  

── Variable type: numeric ──────────────────────────────────────────────────────────────────────────
  skim_variable n_missing complete_rate   mean    sd     p0     p25    p50    p75   p100  hist 
1 Controle              0             1   93.6    3.94   87.3   90.6   93.6   97.6  98.8  ▃▆▂▃▇
2 Positivo              0             1   0.977   0.543  0.101  0.633  0.860  1.31  1.89  ▃▇▆▃▆
3 Tratamento_I          0             1   92.1    3.54   87.5   89.1   91.8   94.7  97.9  ▇▆▆▂▆
4 Tratamento_II         0             1   76.5    1.03   75.3   75.7   76.3   76.7  78.7  ▇▇▃▁▃
```

- A ultima função, "describe()", que pode ser importada com o [pacote "psych"](https://github.com/cran/psych), fornece dados importante sobre assimetria (*skew*) e curtose (*kurtosis*). São os resultados da função:

```
RESULTADOS: Variáveis, 
            Número de observações,
            Média, 
            Desvio padrão (sd), 
            Mediana, 
            Média truncada, 
            Desvio mediano absoluto (mad), 
            Mínimo, 
            Máximo, 
            Intervalo mínimo-máximo, 
            Enviesamento (skew), 
            Curtose (kurtosis), 
            Erro padrão da média (se)
```

- Veja, abaixo, um exemplo do uso de "describe()":

```R
describe(df) #Lembre-se, "df" é o nome dado ao objeto que armazena as informações do modelo I
```

```
              vars  n mean  sd    median  trimmed mad   min    max    range  skew   kurtosis  se
Controle         1 14 93.64 3.94  93.57   93.73   5.57  87.32  98.85  11.53  -0.04  -1.71     1.05
Positivo         2 14 0.980 0.54  0.860   0.970   0.54  0.10   1.89   1.79   0.24   -1.24     0.15
Tratamento_I     3 14 92.11 3.54  91.77   92.01   5.09  87.46  97.93  10.47  0.26   -1.37     0.94
Tratamento_II    4 14 76.46 1.03  76.32   76.36   0.72  75.34  78.72  3.39   1.05   -0.01     0.28
```

- Como discutido inicialmente, é muito comum que os dados importados para o ambiente R tenham vindo de uma planilha. Dessa forma, é interessante que o pesquisador tenha acesso tanto a uma maneira eficaz de importar quanto de exportar seus dados. Supondo que se deseja exportar, para um arquivo .xlsx (Microsoft Excel), os resultados da função "describe(df)", utilizada acima. Para isso, primeiro é preciso atribuir a função a um objeto:

```R
tabela <- describe(df)
```

- Agora, o objeto "tabela" contém as informações produzidas por "describe(df)". Podemos usar esse objeto dentro da função "write.xlsx()" ([pacote "xlsx"](https://github.com/cran/xlsx)) para salvar um arquivo Excel no local desejado do computador:

```R
write.xlsx(x = tabela,                                    #x = nome do objeto ("tabela")
            file = "caminho/no/computador/arquivo.xlsx")  #file = local do arquivo e um nome e a extensão ".xlsx"
```

**5. Gráficos**

- Por conterem diversos componentes individuais personalizáveis, gráficos prontos para publicação geralmente demandam certo tempo e esforço do pesquisador. Esse esforço, porém, só precisa ser feito uma vez, já que o mesmo código, com pequenas modificações, pode ser aplicado para um novo conjunto de dados com estrutura similar.

- Gráficos básicos, por outro lado, são gerados com facilidade. Veja o exemplo da função "boxplot()", nativa do R:

```R
boxplot(df)
```

![Rplot](https://user-images.githubusercontent.com/91353422/149254457-a9d7cbcf-99de-4fe7-9143-7af9fb2853f1.png)

- Com poucas adaptações, é possível selecionar os dados a serem apresentados, a cor de preenchimento e o nome dos grupos:

```R
boxplot(df$Controle,                  #Grupo Controle
        df$Tratamento_I,              #Grupo Tratamento_I
        df$Tratamento_II,             #Grupo Tratamento_II
        col = "lightblue",            #Preenchimento azul claro
        names = c("Grupo 1",          #Nome do grupo 1
                  "Grupo 2",          #Nome do grupo 2
                  "Grupo 3"))         #Nome do grupo 3
```

![Rplot111](https://user-images.githubusercontent.com/91353422/149255230-36900bdc-2de4-4b66-ba19-75228f5af049.png)

- Uma implementação bastante útil para geração de gráficos em R é a possibilidade de segmentar o painel de visualizações, o que permite a combinação de diversos gráficos em simultaneamente. A função "par(mfrow = c(x, y))" determina o número de segmentos horizontais ("x") e verticais ("y") a serem aplicados antes da geração dos gráficos desejados. Veja um exemplo onde repetimos "boxplot(df)" quatro vezes após executar:

```R
par(mfrow = c(2, 2))
```

![Rplotasdex](https://user-images.githubusercontent.com/91353422/149267605-5db7241f-41a2-42d2-92ff-0b274c5a036e.png)

- É sempre importante reestabelecer o padrão "par(mfrow = c(1, 1))" logo após gerar o gráfico desejado, isso evita problemas na execução dos códigos para gráficos seguintes. Veja, agora, um exemplo de implementação onde quatro histogramas, um para cada grupo do modelo I, são gerados em sobreposição:

```R
par(mfrow = c(2, 2))
```

```R
hist(df$Controle,               #Histograma
     freq = F,                  #Sem contagem de frequências
     xlim = c(0,100),           #Limites do eixo x
     col = "white",             #Cor desejada para o gráfico
     main = "Controle",         #Título
     xlab = "Intensidade")      #Legenda do eixo x
lines(density((df$Controle)),   #Gráfico de densidade
      col = "green",            #Cor desejada para o gráfico
      lwd = 2)                  #Espessura da linha
lines(x = c(mean(df$Controle), 
            mean(df$Controle)), #xy da Linha
      y = c(mean(df$Controle), 
            0),                 #xy da Linha
      col = "green",            #Cor desejada para o gráfico
      lty = 2,                  #Tipo de linha (pontilhada)
      lwd = 2)                  #Espessura da linha
lines(x = c(min(df$Controle), 
            min(df$Controle)),  #xy da Linha
      y = c(min(df$Controle), 
            0),                 #xy da Linha
      col = "green",            #Cor desejada para o gráfico
      lty = 2,                  #Tipo de linha (pontilhada)
      lwd = 2)                  #Espessura da linha

#Note que o mesmo código (pequenas alterações) foi utilizado abaixo para os outros três grupos.

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
```

![Rplot0101](https://user-images.githubusercontent.com/91353422/149267419-392ec5bb-a861-48a3-a79f-d946d8dcd481.png)

- É possível gerar gráficos de elevada complexidade utilizando apenas os recursos de base. Mesmo assim, muitas implementações adicionais acabam exigindo a utilização de pacotes não nativos. O melhor recurso para gerar gráficos de elevada qualidade em R é, de longe, ["ggplot2"](https://github.com/tidyverse/ggplot2). Esse pacote gera gráficos altamente personalizáveis, além de possuir uma variedade de extensões (outros pacotes) disponíveis. 

- A forma como ggplot constrói gráficos é um pouco diferente do que já foi apresentado até o momento. Por isso, é necessário, em certos casos, modificar a estrutura dos dados de maneira a convertê-la do formato “largo” (wide) para o formato “longo” (long). Essa transformação pode ser realizada com a função "melt()" do [pacote “reshape2”](https://github.com/cran/reshape2). Compare a tabela abaixo com aquela gerada em "Importando dados de planilhas", que ilustra o formato original dos dados.

```R
dt <- melt(data = df,   #Objeto contendo os dados a serem transformados
           id.vars = 0) #Número ou nome da variável que indexará o dado transformado (0 = usa todas as variáveis)
           
view(dt)                #Executa view() no novo objeto "dt"
```

<img width="219" alt="Screen Shot 2022-01-13 at 02 05 02" src="https://user-images.githubusercontent.com/91353422/149269159-7f38578f-e42c-44f8-86a2-cee63edf7f30.png">

- Como se pode notar, um novo objeto foi criado ("dt") para a tabela transformada, isso preserva o objeto anterior ("df"). 

- O pacote ggplot possui as seguintes propriedades:

```
Componentes de um ggplot:

Origem dos dados
Estética
Representação geométrica
Estatística
Coordenadas espaciais
Rótulos
Temas
```

- Para construir um ggplot, é preciso informar, ao menos, as funções ggplot() e geom_...(), que mapearão os dados e indicarão qual é o tipo de gráfico a ser gerado. Veja um exemplo inicial:

```R
ggplot(data = dt,                               #Cria o gráfico
       aes(x = variable,                        
           y = value)) +                        #Note o sinal de "+", ele conecta os elementos gráficos
  geom_bar(stat = "summary",                    #Determina o tipo (barras)
           fun = "mean", 
           fill = "lightblue") +                
  geom_point(position = position_jitter(0.1),   #Adiciona pontos individuais
             size = 1, 
             shape = 21) +                      
  theme(panel.background = element_blank(),     #Muda o tema
        axis.line.y = element_line("black", 
                                   size = .25), 
        axis.line.x = element_line("black", 
                                   size = .25)) 
```

![Rplottttt01](https://user-images.githubusercontent.com/91353422/149270025-72f5b974-d404-4803-b31c-17763a03613e.png)

- Para se adicionar um elemento geométrico estatístico, como uma *barra de erros*, primeiro é preciso calcular o valor da estatística. Os cálculos de média e desvio padrão, por exemplo, podem ser realizados com os pacotes ["dplyr"](https://github.com/tidyverse/dplyr) (função "group_by()") e ["plyr"](https://github.com/hadley/plyr) (função "summarise()"):

```R
#DICA: aqui, utiliza-se o operador pipe (%>%), que usa a resultante do lado esquerdo como o primeiro argumento da função do lado direito

dtt <- dt %>%                               #Atribui "dt" a "dtt"
  group_by(variable) %>%                    #Agrupa "dt" por variável
  summarise(sd = sd(value, na.rm = TRUE),   #Calcula desvio padrão e média nos grupos de "dt"
            len = mean(value))              

dtt
```

```
variable        sd     len
  <fct>         <dbl>  <dbl>
1 Controle      3.94   93.6  
2 Positivo      0.543  0.977
3 Tratamento_I  3.54   92.1  
4 Tratamento_II 1.03   76.5 
```

- Usando o novo objeto "dtt", podemos aplicar "geom_errorbar()" ao gráfico anterior:

```R
ggplot(data = dt,                                #Cria o gráfico
       aes(x = variable, 
           y = value)) +                      
  geom_bar(stat = "summary",                     #Determina o tipo (barras)
           fun = "mean", 
           fill = "lightblue") +                 
  geom_jitter(position = position_jitter(0.2),   #Adiciona pontos individuais
              color = "black", 
              size = 1, 
              shape = 21) +
  labs(y = 'Unidade de medida do eixo Y',        #Muda os títulos dos eixos x (NULL = remover) e y
       x = NULL) +
  theme(panel.background = element_blank(),      #Muda o tema
        axis.line.y = element_line("black", 
                                   size = .25), 
        axis.line.x = element_line("black", 
                                   size = .25)) + 
  geom_errorbar(aes(x = variable,                 #Adiciona as barras de erro
                    y = len, 
                    ymin = len-sd,                #Média - desvio padrão
                    ymax = len+sd),               #Média + desvio padrão
                data = dtt,                       #Note que utilizamos "dtt" em "data ="
                width = 0.2)                      #Dimensões laterais da barra
```

![Rplotddfdge401](https://user-images.githubusercontent.com/91353422/149272912-3f3a23bc-dc7f-45ad-9ef5-2b502deadc63.png)

**6. Testes de hipóteses**

- Como dito anteriormente, modelos e testes de hipóteses devem ser realizados com bastante cautela. Abaixo, são apresentadas algumas funções típicas para a detecção de valores extremos, avaliação de normalidade e testes de hipóteses.

- Primeiramente, podemos pesquisar valores extremos nos dados utilizando a função "identify_outliers()", do [pacote "rstatix"](https://github.com/kassambara/rstatix). Veja um exemplo:

```R
dt %>%                     #Passa "dt" para a próxima função
  group_by(variable) %>%   #Agrupa "dt" pelas variáveis
  identify_outliers(value) #Identifica valores extremos
```

```
variable          value is.outlier    is.extreme
  <fct>             <dbl> <lgl>         <lgl>     
1 Tratamento_II     78.7 TRUE           FALSE     
2 Tratamento_II     78.5 TRUE           FALSE 
```

- No caso acima, dois valores do grupo "Tratamento_II" foram detectados como "ouliers", mas não "extremos". É importante ficar atento quanto ao critério utilizado para definir um valor "extremo" nas funções escolhidas.

- Além de procurar valores extremos, também é comum investigar a normalidade de um conjuto de dados antes de se realizar um teste de hipóteses que a assume *a priori*. Abaixo, veja um exemplo do teste de Shapiro–Wilk sendo realizado com a função "shapiroTest()", do [pacote "fBasics"](https://github.com/cran/fBasics):

```R
shapiroTest(x = df$Controle) #Testa a normalidade do grupo Controle
```

```
Title:
 Shapiro - Wilk Normality Test

Test Results:
  STATISTIC:
    W: 0.8995
  P VALUE:
    0.111 
```

- Como se observa, o teste indica que não podemos rejeitar a hipótese de normalidade a um nível de confiança igual a 5%.

- Em "Estimativa de tamanho de efeito", vimos a criação de um modelo de ANOVA. Podemos tirar vantagem do modelo para a realização de testes *post hoc*. Um dos procedimentos mais utilizados para esse propósito é o teste de significância honesta de Tukey, que pode ser gerado pela função "TukeyHSD()", do [pacote "stats"](https://github.com/SurajGupta/r-source/tree/master/src/library/stats/R). Reveja o modelo:

```R
aav <- aov(value ~ variable, data = dt) #Criação de um modelo de ANOVA (no objeto "aav") com os dados do modelo
```

- Utilizando o modelo "aav", podemos aplicar o teste de Tukey. Veja abaixo:

```R
TukeyHSD(aav,              #Nome do modelo ANOVA criado
         conf.level = .95) #Nível de confiança atribuído ao teste (5%)
```

```
Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = dt$value ~ dt$variable)

$`dt$variable`
                                 diff        lwr        upr     p adj
Positivo-Controle          -92.663591 -95.381553 -89.945630 0.0000000
Tratamento_I-Controle       -1.528913  -4.246874   1.189048 0.4489958
Tratamento_II-Controle     -17.183906 -19.901867 -14.465945 0.0000000
Tratamento_I-Positivo       91.134678  88.416717  93.852640 0.0000000
Tratamento_II-Positivo      75.479685  72.761724  78.197647 0.0000000
Tratamento_II-Tratamento_I -15.654993 -18.372954 -12.937032 0.0000000
```

- Note como a única comparação, de acordo com o teste, que rejeira a hipótese nula é Tratamento_I x Controle.

- Finalmente, os testes *t* são amplamente utilizados para comparar entre duas variáveis. Aqui, podemos simular um teste *t* com correção de Welch sendo realizado para comparar os grupos Tratamento_I e Controle. Para tanto, usamos "t.test()", do [pacote "stats"](https://github.com/SurajGupta/r-source/tree/master/src/library/stats/R):

```R
t.test(df$Controle, df$Tratamento_I) 
```

```
Welch Two Sample t-test

data:  df$Controle and df$Tratamento_I
t = 1.081, df = 25.703, p-value = 0.2897
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.379910  4.437736
sample estimates:
mean of x  mean of y 
93.64019   92.11128 
```

**Conclusão**

- O crescimento no número de usuários que procura linguagens como R e Python para a análise de dados científicos, em detrimento de ferramentas mais limitadas e/ou pagas, é um sinal de progresso a favor da reprodutibilidade na ciência. O objetivo do presente repositório é marcar o início de um esforço direcionado a fornecer recursos estruturados, e em língua portuguesa, a pesquisadores em processo de transição para a linguagem R.

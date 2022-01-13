<div style="display: inline_block"><br>
  <img align="center" alt="fig1" height="120" width="120" src="https://avatars.githubusercontent.com/u/91353422?v=4">
</div>


------------------------------------------------------------------------------------------------------------------------------
## heRcules: um repositório de scripts R anotados em Português

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
aav <- aov(value ~ variable, data = df) #Criação de um modelo de ANOVA (no objeto "aav") com os dados do modelo

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

- A segunda função, "stat.desc()", depende do pacote "pastecs" (veja como importar um pacote em "Importando dados de planilhas") e fornece os seguintes resultados:

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

- A proxima função, "skim()", do pacote "skimr", é interessante pois gera um conjunto valioso de informações estatísticas sobre os dados e ainda fornece um "histograma", que confere uma perspectiva inical sobre a distribuição dos valores. São os resultados:

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

- A ultima função, "describe()", que pode ser importada com o pacote "psych", fornece dados importante sobre assimetria (*skew*) e curtose (*kurtosis*). São os resultados da função:

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

- Agora, o objeto "tabela" contém as informações produzidas por "describe(df)". Podemos usar esse objeto dentro da função "write.xlsx()" (pacote "xlsx") para salvar um arquivo Excel no local desejado do computador:

```R
write.xlsx(x = tabela,                                    #x = nome do objeto ("tabela")
            file = "caminho/no/computador/arquivo.xlsx")  #file = local do arquivo e um nome e a extensão ".xlsx"
```

**5. Gráficos**

```R

```

[EM CONSTRUÇÃO]




















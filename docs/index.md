<div style="display: inline_block"><br>
  <img align="center" alt="fig1" height="120" width="120" src="https://avatars.githubusercontent.com/u/91353422?v=4">
</div>

------------------------------------------------------------------------------------------------------------------------------
## heRcules: um repositório de scripts R anotados em Português

**1. Repositório de scripts R para a análise de dados em Ciências Biológicas e da Saúde. Meu objetivo aqui é:**

- Fornecer scripts R anotados para facilitar a transição de usuários de softwares pagos;

- Desenvolver protocolos gerais passo a passo para a análise de dados científicos;

- Fornecer arquivos de markdown estruturados para facilitar o relatório da análise de dados;

### Aprendendo o básico da linguagem R

**1. Ao usuário completamente inexperiente no uso da linguagem R, recomenda-se a leitura do guia:**

- [“Introdução ao R"](https://vanderleidebastiani.github.io/tutoriais/Introducao_ao_R.html), de Vanderlei Júlio Debastiani (@vanderleidebastiani)

**2. Se quiser saber como instalar o R (e o ambiente de desenvolvimento RStudio), acesse:**

- [Ciência de Dados em R](https://livro.curso-r.com/1-1-instalacao-do-r.html), de Athos Damiani, Beatriz Milz, Caio Lente, Daniel Falbel, Fernando Correa, Julio Trecenti, Nicole Luduvice e William Amorim (@Curso-R)

### Componentes do modelo I

------------------------------------------------------------------------------------------------------------------------------

**ATENÇÃO!** Se for utilizar o modelo em uma publicação, cite:

Freitas, H.R. heRcules: A repository for annotated R scripts in Portuguese for scientific data analysis. SciELO Preprints. 2022. Version 1. doi: 10.1590/SciELOPreprints.3389

[Clique aqui para acessar](https://doi.org/10.1590/SciELOPreprints.3389)

------------------------------------------------------------------------------------------------------------------------------

**1. Importando dados de planilhas**

<details><summary>Expandir</summary>
<p>

<p>- O caso mais habitual para pesquisas em Biociências é a importação de dados contidos em planilhas, normalmente salvas no formato '.xlsx'. Para esse tipo de documento, basta que o pesquisador execute o seguinte código:<p>

```R
df <- readxl::read_excel("caminho/do/arquivo/no/computador/nomedoarquivo.xlsx")
```

<p>- No caso acima, o comando importará para o ambiente R a primeira aba da planilha e atribuirá ao objeto “df” as informações contidas nela. O uso de "df", porém, é apenas uma convenção. Os dados poderiam ser importados da mesma maneira para um objeto chamado "obj", por exemplo. Uma visão parcial do objeto criado pode ser obtida através do comando "df" (ou "obj"), mas é possível interagir de forma mais completa (típico de planilhas) através do comando "View(df)" (sem as aspas).<p>

```R
View(df)
```

<img align="center" width="430" alt="fig2" src="https://user-images.githubusercontent.com/91353422/149055241-8d88e999-11d5-47e8-83f2-84c47ef69488.png">

<p>- É importante destacar que a maioria das funções utilizadas no presente modelo dependem da instalação de pacotes, como é habitual em R. Para instalar e importar um determinado pacote no seu ambiente R, utilizam-se os seguintes comandos:<p>

```R
install.packages("nomedopacote") #Aguardar a instalação e, então, executar:

library(nomedopacote)
```

</p>
</details>

**2. Estimativas de poder estatístico e tamanho amostral**

<details><summary>Expandir</summary>
<p>

<p>- Um dos elementos mais importantes do planejamento de experimentos é a estimativa de tamanho amostral. Uma leitura mais detalhada sobre o assunto pode ser encontrada no texto ["Poder do teste e tamanho do efeito"](https://biostatistics-uem.github.io/Bio/aula9/effectsize.html), de Felipe Barletta e Isolde Previdelli (@Biostatistics-UEM).<p>

<p>- Utilizando o [pacote "pwr"](https://github.com/heliosdrm/pwr), as estimativas de *tamanho amostral* e *poder estatístico* para a análise de variância (ANOVA) podem ser realizadas utilizando o mesmo código, sendo apenas necessário substituir o valor desejado por “NULL". Veja o exemplo abaixo para a estimativa de tamanho amostral:<p>

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

<p>- O mesmo pacote, "pwr", pode ser utilizado para gerar um gráfico da estimativa "av", que permite visualizar a variação de poder estatístico em função do tamanho amostral:<p>

```R
plot.power.htest(av)
```

![Rplot](https://user-images.githubusercontent.com/91353422/149058642-1f695017-31d4-414b-9634-d9e065337664.png)

<p>- Os parâmetros acima também podem ser obtidos para outros testes, como os testes *t* [(veja mais detalhes no artigo)](https://doi.org/10.1590/SciELOPreprints.3389).<p>

</p>
</details>    

**3. Estimativa de tamanho de efeito**

<details><summary>Expandir</summary>
<p>

<p>- O pacote “pwr” oferece, ainda, a possibilidade de se estimar o tamanho de efeito sem a necessidade de calculadoras ou aplicativos externos. No presente modelo, pode-se observar um exemplo da análise de tamanho de efeito (Cohen D) entre os grupos “Controle” e “Tratamento_II” (ver tabela em "Importando dados de planilhas"), que resulta em um d = 5.96, com intervalo de confiança entre 4.15 e 7.78.<p>

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

</p>
</details>

[EM CONSTRUÇÃO]

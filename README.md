<div style="display: inline_block"><br>
  <img align="center" alt="fig1" height="120" width="120" src="https://avatars.githubusercontent.com/u/91353422?v=4">
</div>

------------------------------------------------------------------------------------------------------------------------------
## heRcules: um repositório de scripts R anotados em Português

1. Repositório de scripts R para a análise de dados em Ciências Biológicas e da Saúde. Meu objetivo aqui é:

- Fornecer scripts R anotados para facilitar a transição de usuários de softwares pagos;

- Desenvolver protocolos gerais passo a passo para a análise de dados científicos;

- Fornecer arquivos de markdown estruturados para facilitar o relatório da análise de dados;

### Aprendendo o básico da linguagem R:

1. Ao usuário completamente inexperiente no uso da linguagem R, recomenda-se a leitura do guia:

- [“Introdução ao R"](https://vanderleidebastiani.github.io/tutoriais/Introducao_ao_R.html), de Vanderlei Júlio Debastiani (@vanderleidebastiani)

2. Se quiser saber como instalar o R (e o ambiente de desenvolvimento RStudio), acesse:

- [Ciência de Dados em R](https://livro.curso-r.com/1-1-instalacao-do-r.html), de Athos Damiani, Beatriz Milz, Caio Lente, Daniel Falbel, Fernando Correa, Julio Trecenti, Nicole Luduvice e William Amorim (@Curso-R)

### Componentes do modelo I:

------------------------------------------------------------------------------------------------------------------------------

**ATENÇÃO!** Se for utilizar o modelo em uma publicação, cite:

Freitas, H.R. heRcules: A repository for annotated R scripts in Portuguese for scientific data analysis. SciELO Preprints. 2022. Version 1. doi: 10.1590/SciELOPreprints.3389

[Clique aqui para acessar](https://doi.org/10.1590/SciELOPreprints.3389)

------------------------------------------------------------------------------------------------------------------------------

1. Importando dados de planilhas

- O caso mais habitual para pesquisas em Biociências é a importação de dados contidos em planilhas, normalmente salvas no formato '.xlsx'. Para esse tipo de documento, basta que o pesquisador execute o seguinte código:

```R
df <- readxl::read_excel("caminho/do/arquivo/no/computador/nomedoarquivo.xlsx")
```

- No caso acima, o comando importará para o ambiente R a primeira aba da planilha e atribuirá ao objeto “df” as informações contidas nela. O uso de "df", porém, é apenas uma convenção. Os dados poderiam ser importados da mesma maneira para um objeto chamado "obj", por exemplo. Uma visão parcial do objeto criado pode ser obtida através do comando "df" (ou "obj"), mas é possível interagir de forma mais completa (típico de planilhas) através do comando "view(df)" (sem as aspas).

2. Cálculo de poder estatístico e tamanho amostral

- Um dos elementos mais importantes do planejamento de experimentos em projetos de pesquisa é a estimativa de tamanho amostral. 






---
layout: post
title:  "Por que utilizar o Jekyll?"
date: 2015-05-06
categories: Development
comments: true
author: Leonardo Rifeli
isResume: 1
resume: Neste post irei descrever por que optei por utilizar o Jekyll. Mostrarei como ele é e como funciona.
---


## Introdução

Primeiramente irei explicar o que é o Jekyll.

**Jekyll** é um gerenciador de códigos estáticos. Isso mesmo, ele não faz uso de banco de dados e não requesita um servidor robusto para funcionar, podendo utilizar o **Github Pages** para hospedar o site. Você pode desenvolver páginas e até mesmo um blog de forma estática, apenas utilizando **HTML** que você provavelmente já conhece. Ele é baseado em vários formatos como **Markdown** para formatação de textos e posts e um padrão de template chamado **Liquid** com um pouco de **YAML** para exibir e guardar os dados das variáveis.

Mostrarei como o **Jekyll** funciona (o que eu aprendi até aqui) posteriormente como iniciar um projeto utilizando-o.

## Estrutura de diretórios

Todo arquivo e/ou diretório que tiver **underscore (exemplo: _includes)** no começo, o **Jekyll** irá ignorar no pacote final, quando rodar o **<code>jekyll build</code>** para gerar os arquivos para o site (os arquivo do site ficarão dentro do diretório **_site**).

![Structure Directory](/img/posts/2015-05-05-structure-directory.png)

O diretório **_includes** guarda arquivos que serão reutilizados nas páginas do projeto, como, **header**, **footer**, **sidebar**, **nav** ou qualquer outra coisa de acordo com o layout.

No diretório **_layouts** você vai colocar os padrões de layout de páginas. Imagine que existam páginas com formatos de estruturas diferentes. Exemplo: **default.html**, **article.html**, **post.html**, e assim por diante.

O diretório **_site** é o **build** do seu projeto. É ali que o **Jekyll** coloca a versão final estática do site (que é gerado executando **<code>jekyll build</code>** no terminal), pronto para ser publicado.

Há pessoas que preferem deixar o diretório **_site** versionável no GIT, e há pessoas que o colocam no **.gitignore** e utilizam outro diretório (**web** por exemplo). Basta executar o **<code>jekyll build</code>** copiar os arquivos gerados no diretório **_site** para o diretório **web**.

{% highlight text %}
|-- _config.yml
|-- _includes/
|-- _layouts/
|-- _posts/
|-- _site/
|-- about.md # => será uma página chamada about
|-- index.html # => http://projeto.com
└── feed.xml # => http://projeto.com/feed.xml
{% endhighlight %}

## YAML
O formato YAML foi desenvolvido para facilidar o entendimento e a escrita dentro dos arquivos no respectivo formato.

Qualquer arquivo no respectivo formato e que contenha um bloco em YAML será processado pelo jekyll como um arquivo especial, o pessoal do **Jekyll** o chama de **front-matter**. O front-matter precisa estar em um formato válido de YAML. Toda a página no Jekyl deverá ser iniciada da seguinte maneira:

{% highlight text %}
---
layout: default
title: Home
---
{% endhighlight %}

Restritamente deverá começar com os três traços e finalizar com os mesmos. Sem choro nem vela. O código YAML são as variáveis **<code>layout</code>** e **<code>title</code>**

## Entendendo o arquivo _config.yml

Tal arquivo é responsável por armazenar as variável que serão utilizadas dentro do site. Exemplo: Copyright do footer, link das redes sociais, e-mail, mensagens, etc.

Exemplo:

{% highlight text %}
## SITE CONFIGURATION
baseurl: ""
url: "https://leonardorifeli.com"

## THEME-SPECIFIC CONFIGURATION
theme:
  title: Leonardo Rifeli
  email: leonardorifeli@gmail.com
  empresa: Wab <wab.com.br>
  facebook: false
  twitter: true
  twitter_base: leonardorifeli
{% endhighlight %}

Para utilizar as variáveis dentro do site, segue um exemplo implementado no arquivo **<code>_includes/head.html</code>**:

{% highlight html %}
<title>{`{ site.theme.title }`}</title>
<link rel="stylesheet" href="{`{ /css/main.css" | prepend: site.baseurl }`}">
{% endhighlight %}

**Obs.:** Removendo as aspas simples, ele irá utilizar o valor que foi armazenado em cada respectiva variável.

## Iniciando

Bom, após uma descrição de como o Jekyll funciona (ou melhor, o que aprendi até agora). Irei demonstrar como iniciar um novo projeto utilizando o **Jekyll**. Irei demonstrar utilizando um repositório no **Github** e hospedando no **Github Pages**.

Acesse sua conta no Github, crie um novo repositório com o nome da organização e utilizando o sufixo <b>.github.io</b>. Exemplo: <b>leonardorifeli.github.io</b>.

Em seguido acesse a página do repositório e vá em **"Settings"** e no box **"GitHub Pages"** clique em **"Automatic page generator"**, na etapa seguinte clique em **"Continue to layouts"**. O próximo pasos será selecionar um layout (não se preocupe muito quanto a isso), simplesmente clique em **"Publish page"**.

Após finalizar clone o repositório.

## Dependências

Para iniciar um projeto com Jekyll será necessário instalar:

1. [Ruby](https://www.ruby-lang.org/en/downloads/){:target="_blank"};
2. [RubyGems](https://rubygems.org/pages/download){:target="_blank"}.
3. Linux, Unix, or Mac OS X;
4. [NodeJS](https://nodejs.org/){:target="_blank"}, or another JavaScript runtime.

PS: Mais informações quanto a instalação das dependências, você encontra na [documentação oficial do **Jekyll**](http://jekyllrb.com/docs/installation/){:target="_blank"}

## Instalando

Após ter instalado as dependências citadas acima, instale o **Jekyll**:

**<code>gem install jekyll</code>**

**Vá para o diretório do repositório clonado** remova todos os arquivos que vieram junto ao repositório, deixando o diretório vazio e inicie um projeto com o Jekyll, executando (dentro do diretório do repositório clonado):

**<code>jekyll new ./</code>**

Você pode executar **<code>jekyll server</code>**, automaticamente ele executará **<code>jekyll build</code>** para gerar o diretório **_site** com os arquivos estátivos. Você poderá verificar acessando **localhost:4000**.

## Recomendação

Você pode apenas comitar as alterações, ou adicionar o diretório **_site** no ignore do GIT, criar um diretório **web** por exemplo, copiar/colar os arquivos gerados no diretório **_site** para o diretório **web** e comitar.

A primeira opção é recomendada caso vá utilizar o Github Page e a segunda opção é recomendada caso vá utilizar um servidor mesmo assim.


## Aparência

Quanto ao templete/tema você pode desenvolver um, apenas fique familiarizado com o Jekyll para entender toda a estrutura e desenvolver sem impecilios. Ou, na internet existe vários sites que disponibilizam e/ou vendem templates/temas para Jekyll.

**Recomendação:** [jekyllthemes.org](http://jekyllthemes.org/){:target="_blank"}

## Comandos

**<code>jekyll build</code>**: Irá gerar as páginas estáticas de acordo com os arquivos de configuração e os demais.

**<code>jekyll build --watch</code>**: Deixa o build verificando quando um arquivo é alterado gerando o build novamente. Recomendado utilizar quando estiver desenvolvendo e/ou implementando o template/tema.

**<code>jekyll server</code>**: Inicia um servidor, como default em http://localhost:4000/ para acesso local. Só será utilizado para quando estiver esenvolvendo e/ou implementando o template/tema.

**<code>jekyll -h</code>**: Todos os demais comandos disponíveis.

## Não recomendo

Nem pense em utiliza-lo com **sites** mais **robustos**, com **internacionalização**, **controle** disso, **controle** daquilo. O **Jekyll** é simples, objetivo e não é robusto nestes aspectos.

## Referências

1. **Outro artigo sobre o Jekyll:** [tableless.com.br/jekyll-servindo-sites-estaticos](http://tableless.com.br/jekyll-servindo-sites-estaticos/){:target="_blank"};

2. **Documentação oficial:** [jekyllrb.com](http://jekyllrb.com){:target="_blank"}

3. **Github pages:** [pages.github.com](https://pages.github.com/){:target="_blank"}

4. **Repositório:** [utilizado no artigo](https://github.com/leonardorifeli/leonardorifeli.github.io){:target="_blank"}

## Conclusão

Optei pela utilização do **Jekyll** pelo fato de não necessitar de um servidor robusto para o site funcionar e pela facilidade de alteração, inclusão de novos artigos e/ou páginas. É somente criar um arquivo em **YAML** e digitar o escopo utilizando **Markdown**, executar o **<code>jekyll build</code>** e comitar, pronto, sem dificuldades, resolvido. O Jekyll abre um leque de opções de personalização, agilidade no desenvolvimento de sites pequenos (sim, eu disse pequenos!).

Futuramente irei postar um artigo com melhor aprofundamento no **Github Pages**, descrevendo as funcionalidades, customizar domínio, e por aí vai.

**PS:** Qualquer erro ortográfico e/ou digitação, reporte-os, auxilia-nos a evolução!

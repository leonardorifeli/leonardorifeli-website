---
layout: post
title:  "Falando sobre a estrutura do meu blog"
date: 2016-11-13
categories: Development
subcategorie: Tip
comments: true
author: Leonardo Rifeli
isResume: 1
resume: Neste artigo, falarei sobre a estrutura do meu blog, um resumo geral de como ele funciona, como faço as publicações, os macetes envolvidos, etc. Recentemente, recebi várias perguntas sobre isso e decidir fazer este artigo para compartilhar isso com você.
---

## Sumário

- Introdução;
- Resumo da estrutura;
- Resumo sobre o Jekyll;
- Como usar o Github Pages;
- Como configurar seu domínio no Github Pages;
- Como automatizar o build;
- Como configurar HTTPS (via cloudflare);
- Referências;
- Conclusão.

## Introdução

Você deve ter percebido que estou tentando manter uma frequência de pelo menos uma publicação por semana, [veja aqui o artigo da semana passada](/development/2016/11/05/docker-vamos-falar-sobre-virtualizacao.html){:target="_blank"}.

Antes de entrar neste artigo, certifique-se que você já leu o meu outro artigo, [`Porque utilizar o Jekyll`](https://leonardorifeli.com/development/2015/05/06/porque-utilizar-o-jekyll.html){:target="_blank"}.

Enfim, vamos direto ao ponto. Falarei sobre a estrutura do meu blog. Um resumo geral de como ele funciona, como faço as publicações, os macetes envolvidos, etc. E também, como você pode fazer algo parecido. Recentemente, recebi várias perguntas sobre isso e decidir fazer este artigo para compartilhar isso com você.

Vou escrevendo este magnífico artigo, enquando escuto o set de **[Tech House #023 do Mark Jones](https://www.youtube.com/watch?v=tAP9m2XUqjc){:target="_blank"}**.

## Resumo da estrutura

Nesto ponto, irei dar um breve resumo do que é utilizado no meu blog e nos próximos tópicos, entrarei em mais detalhes.

Basicamente, meu blog é feito em [Jekyll](https://jekyllrb.com/) com um template adaptado. Atualmente, ele está hospedado no Github Pages e possuí uma [`CDN (Content Delivery Network)`](https://pt.wikipedia.org/wiki/Content_Delivery_Network){:target="_blank"} que neste caso, utilizo o [Cloud Flare](https://www.cloudflare.com){:target="_blank"}.

Mesmo usando o Github Pages, eu configurei meu domínio `leonardorifeli.com` para funcionar com **HTTPs (via Cloud Flare)**. Se você acessar [`leonardorifeli.github.io`](http://leonardorifeli.github.io){:target="_blank"}, você será redirecionado para [`leonardorifeli.com` (com HTTPS)](https://leonardorifeli.com){:target="_blank"}.

E para fazer as publicações? O Jekyll funciona com [Markdown](https://daringfireball.net/projects/markdown/){:target="_blank"}, esse foi o ponto principal para a minha adesão ao Jekyll, com isso, eu escrevo os artigos usando Markdown.

No repositório do meu [blog](https://github.com/leonardorifeli/leonardorifeli.github.io){:target="_blank"} existem duas branchs principais, sendo, `gh-pages` e `master`. Eu automatizei o build (utilizando o [travis](https://github.com/leonardorifeli/leonardorifeli.github.io/blob/gh-pages/.travis.yml){:target="_blank"}), com essa automatização, sempre que é efetuado um push para a branch `gh-pages`, ele irá executar o **bash abaixo** e depois que tudo estiver **OK**, é só fazer um PR (Pull Request) da branch `gh-pages` para a `master` e pronto, está no ar.

Arquivo **.travis.yml**:
<script src="https://gist.github.com/leonardorifeli/47584455fdfc437341d758b89c03096d.js?file=.travis.yml"></script>
<span class="space">&nbsp;</span>

Arquivo **build.sh**:
<script src="https://gist.github.com/leonardorifeli/47584455fdfc437341d758b89c03096d.js?file=bash.sh"></script>
<span class="space">&nbsp;</span>

Salientando que, todos os pushs que eu efetuo, são na branch `gh-pages` e não (nunca e jamais) na `master`.

**Adicional:** Eu utilizo o Jekyll há mais de um ano (você pode conferir mais sobre o Jekyll no meu artigo [Porque utilizar o Jekyll](https://leonardorifeli.com/development/2015/05/06/porque-utilizar-o-jekyll.html){:target="_blank"}).

## Resumo sobre o Jekyll

{:.center}
![docker](https://jekyllrb.com/img/logo-2x.png){:style="width: 30%;"}

Jekyll é um gerenciador de códigos estáticos. Isso mesmo, ele não faz uso de banco de dados e não requesita um servidor robusto para funciona. Um dos benefécios é poder utilizar o Github Pages para hospedar o site. Ou seja, você pode desenvolver páginas e até mesmo um blog de forma estática, apenas utilizando HTML (e claro, Markdown) que você provavelmente já conhece. Ele é baseado em vários formatos como Markdown (conforme já dito) para formatação de textos e posts e um padrão de template chamado Liquid com um pouco de **YAML** para os arquivos de configurações.

Você deve ter visto mais no meu artigo sobre, [Porque utilizar o Jekyll](/development/2015/05/06/porque-utilizar-o-jekyll.html){:target="_blank"}. Se não, acesse para conhecer mais detalhes sobre este cara. Salientando que, você irá ler a palavra **Jekyll** demasiadas vezes.

## Como usar o Github Pages

Eu expliquei um pouco, no artigo já mencionado, mas, aqui vai um review.

<iframe width="100%" height="350" src="https://www.youtube.com/embed/2MsN8gpT6jY" frameborder="0" allowfullscreen></iframe>
<span class="space">&nbsp;</span>

Acesse sua conta no Github, crie um novo repositório com o nome da organização, utilizando o sufixo `.github.io`. Exemplo: `leonardorifeli.github.io`.

Em seguido acesse a página do repositório, clique em `Settings` e depois no box `GitHub Pages` clique em `Automatic page generator`, na etapa seguinte clique em `Continue to layouts`. O próximo passo será selecionar um layout (não se preocupe muito quanto a isso), simplesmente clique em `Publish page`.

Você poderá encontrar mais detalhes sobre este tópico no site do [Github Pages](https://pages.github.com/){:target="_blank"}.

Após finalizar você poderá clonar o projeto e substituir os arquivos por algum projeto Jekyll já configurado que você tenha encontrado na internet.

Logo após a configuração, você poderá acessar com `nome-repositorio.github.io`. Porém, acredito que você já tenha um domínio e queira que seu blog seja acessível por ele, exemplo, seudominio.com. Chega mais que é o próximo tópico.

Alguns sites para você encontrar temas para Jekyll:

- [github.com/jekyll/jekyll/wiki/Themes](https://github.com/jekyll/jekyll/wiki/Themes){:target="_blank"};
- [github.com/planetjekyll/awesome-jekyll-themes](https://github.com/planetjekyll/awesome-jekyll-themes){:target="_blank"};
- [jekyllthemes.org](http://jekyllthemes.org/){:target="_blank"};
- [jekyllthemes.io](https://jekyllthemes.io/){:target="_blank"};
- [jekyll.tips](http://jekyll.tips/templates/){:target="_blank"};
- [drjekyllthemes.github.io](https://drjekyllthemes.github.io/){:target="_blank"}.

**PS.:** você pode criar Github Pages para qualquer repositório. Eu já vi até documentação do projeto, hospedado no Github Pages (pelo repositório do projeto).

## Como configurar seu domínio no Github Pages

Esta etapa, eu considero uma das mais tranquilas. Você precisará apenas, configurar algumas entradas DNS no seu domínio e adicionar um arquivo no repositório.

E como fazer isso?

Saliento que, se você for utilizar uma CDN (detalharei nos próximos tópicos), você precisará alterar novamente a zona de DNS do seu domínio, isso impactará apenas em tempo de propagação do DNS.

Vamos ao que interessa, você precisará acessar as configurações das zonas de DNS do seu domínio e configurar algumas entradas, conforme abaixo:

- Entrada do tipo A: `192.30.252.153`
- Entrada do tipo A: `192.30.252.154`
- Entrada do tipo CNAME: `dominio-do-repositorio.github.io`

Feito isso, agora é moleza, basta criar um arquivo chamado CNAME (em maiúsculo) e dentro deste arquivo, você irá colocar o seu domínio, sem nenhum protocolo ou **www**, apenas o domínio. Exemplo [meu CNAME](https://github.com/leonardorifeli/leonardorifeli.github.io/blob/gh-pages/CNAME){:target="_blank"}.

Feito isso, é só esperar propagar.

Alguns links adicionais estão nas referências, aventure-se!

## Como automatizar o build

{:.center}
![travis ci logo](https://cdn.travis-ci.com/images/logos/TravisCI-Full-Color-7f5db09495c8b09c21cb678c4de18d21.png){:style="width: 50%;"}

Como eu falei, no tópico **Resumo da estrutura**, eu utilizo duas branchs no projeto (gh-pages e master). A branch **master** é a principal do projeto, quando alguém acessar meu blog, o **Github Pages** puxa os arquivos da **master**. Ou seja, sempre que eu faço alterações no blog (incrementais ou novos artigos) eu efetuo o `git push` para a **gh-pages** e abro um **PR** (pull request) para a **master**.

Aqui vai uma observação interessante, por **default**, o Github Pages puxa os arquivos da `gh-pages`, mas, você pode mudar isso, através das `setting` do repositório, conforme a imagem abaixo.

{:.center}
![branch default to githug pages](/img/posts/2016/11/13/setting-master.png){:style="width: 70%;text-align:center"}

Mas, a branch default do projeto é a `gh-pages`. Isso você pode mudar nas `settings` do repositório também.

O travis é um produto do Github para automatização de processos, ele é um [CI](https://en.wikipedia.org/wiki/Continuous_integration){:target="_blank"}. Ele lê o arquivo **.travis.yml** do seu repositório e executa as rotinas específicadas no arquivo.

E como configurar o [travis](https://travis-ci.org/){:target="_blank"}?

É simples, você vai acessar o site do travis, logar com a sua conta do Github e sincronizar todos os seus repositórios. Com isso, você terá uma lista dos repositórios (apenas os repositórios públicos).

Quando você estiver logado, você verá algo como a imagem abaixo, onde poderá habilitar o travis para os repositório e ver um mini tutorial de como automatizar as tarefas com o travis.

{:.center}
![travis example](/img/posts/2016/11/13/travis-build.png){:style="width: 70%;"}

O próximo passo é simples. Como você percebeu na imagem acima, é simples, basta criar um arquivo com o nome **.travis.yml** (onde você especificará o que irá acontecer quando efetuar algum push em alguma branch) e enviá-lo para o repositório.

No meu blog, conforme eu falei no tópico do resumo, eu utilizo o arquivo abaixo, quando é efetuado um `git push`, o travis irá executar o arquivo **build.sh**, que irá rodar o comando `$ bundle exec jekyll build` para iniciar o build do jekyll.

Arquivo **.travis.yml**:
<script src="https://gist.github.com/leonardorifeli/47584455fdfc437341d758b89c03096d.js?file=.travis.yml"></script>
<span class="space">&nbsp;</span>

Arquivo **build.sh**:
<script src="https://gist.github.com/leonardorifeli/47584455fdfc437341d758b89c03096d.js?file=bash.sh"></script>
<span class="space">&nbsp;</span>

Caso não tenha visto o artigo [Porque utilizar o Jekyll](/development/2015/05/06/porque-utilizar-o-jekyll.html){:target="_blank"}, o comando `$ bundle exec jekyll build` irá gerar os arquivos estáticos no diretório `_site`.

Com esse build, o travis que irá gerar os arquivos estáticos quando você mergear um **PR** (pull request) da branch `gh-pages` para `master`. Alguns segundos após o merge, as alterações estarão online.

## Como configurar https

{:.center}
![cloud flare logo](/img/posts/2016/11/13/cloud-flare.png){:style="width: 50%;"}

Este tópico é um adicional que eu aprendi recentemente, lendo o artigo [HTTPS no Github Pages com Custom Domain](https://willianjusten.com.br/https-no-github-pages-com-custom-domain/){:target="_blank"}, do Willian Justen. Ah, ele tem um [curso sobre Jekyll](http://willianjusten.teachable.com/p/criando-sites-estaticos-com-jekyll){:target="_blank"}, gratuito, corre lá.

Quando eu pesquisei sobre, meu interesse era somente em ter o protocolo HTTPS funcionando e acabei tendo um adicional, uma CDN para otimizar o blog. Coloquei este tópico, apenas para você saber que é possível usar o Github Pages com HTTPS e para configurar você pode ler o [artigo do Willian Justen (aquele que falei logo acima)](https://willianjusten.com.br/https-no-github-pages-com-custom-domain/){:target="_blank"}, eu segui ele e funcionou super bem.

Mas, o que é interessante em ter HTTPS e a CDN?

A [Google fez um post](https://webmasters.googleblog.com/2014/08/https-as-ranking-signal.html){:target="_blank"}, em Agosto/2014, falando que irá utilizar o HTTPS como um elemento para pontuação nas buscas. Mais do que argumentado.

Quanto a CDN, eu não cheguei a medir o quanto tive de ganho. Porém, a Cloud Flare disponibiliza alguns relatórios super interessantes, abaixo mostro alguns.

{:.center}
![requests report](/img/posts/2016/11/13/requests.png){:style="width: 100%;"}
Relatório de requests e arquivos cacheados/não cacheados.

{:.center}
![performance report](/img/posts/2016/11/13/performance.png){:style="width: 100%;"}
Relatório sobre performance.

Concluindo, eu adicionei este tópico como um adicional, propondo algo diferente para você utilizar nas páginas que for fazer com Jekyll. O interessante, é que, se for um blog pequeno, como o meu, o plano da Cloud Flare pode ser o gratuito.

## Referências

- [Leonardo Rifeli - Porque utilizar o Jekyll](https://leonardorifeli.com/development/2015/05/06/porque-utilizar-o-jekyll.html){:target="_blank"};
- [Github Pages](https://pages.github.com/){:target="_blank"};
- [Setting up an apex domain](https://help.github.com/articles/setting-up-an-apex-domain/){:target="_blank"};
- [Using a custom domain with Github Pages](https://help.github.com/articles/using-a-custom-domain-with-github-pages){:target="_blank"};
- [Como ter domínio próprio no Github Pages](https://willianjusten.com.br/dominio-proprio-no-github-pages/){:target="_blank"};
- [Travis CI for Complete Beginners](https://docs.travis-ci.com/user/for-beginners){:target="_blank"};
- [HTTPS no Github Pages com Custom Domain](https://willianjusten.com.br/https-no-github-pages-com-custom-domain/){:target="_blank"};
- [Curso do Willian Justen - Criando sites estáticos com Jekyll](http://willianjusten.teachable.com/p/criando-sites-estaticos-com-jekyll){:target="_blank"}.

## Conclusão

A ideia principal é compartilhar com você o que eu aprendi e venho fazendo no meu blog. Espero que este conteúdo lhe auxilie em algo e tenha algum ponto positivo para você.

Obrigado pelo leitura.

Peço que comente sobre o que achou deste artigo, qualquer feedback será importante para o desenvolvimento dos outros artigos.

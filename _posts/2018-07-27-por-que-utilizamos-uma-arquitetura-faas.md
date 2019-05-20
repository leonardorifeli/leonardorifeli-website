---
layout: post
title:  "Por que utilizamos uma arquitetura FaaS?"
date: 2018-07-27
categories: [development, serverless]
author: leonardorifeli
comments: true
tags: [featured]
image: https://cdn-images-1.medium.com/max/1600/0*4ruGoRh2LUk7pvNq.jpg
---

Em algumas palestras ouvimos dizer que este assunto é **hype**, mas quando necessitamos de informações mais concretas sobre o assunto, não se encontra muito conteúdo em português ou até mesmo cases de utilização e sucesso.

Conosco aqui na **reviewr** não foi diferente. Uma parte da nossa arquitetura é completamente em Serverless/FaaS e tivemos grandes desafios. Eu e o Marcelo Andrade (CTO da reviewr) palestramos no StartupSC Summit 2018 e gostaríamos de compartilhar com você nossa experiência.

O que é Serverless?
Sempre que entramos neste assunto, utilizamos muito os argumentos e definições do mestre Mike Roberts:

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/1200/1*KaiUEw1va-CTT1KvfK5QVQ.png"/>
</div>

Ou seja, serverless possui duas possíveis definições: aplicações que dependem significativamente de serviços de terceiro (Backend como serviço, também conhecido na sigla BaaS). Como também, um contêiner efêmero para execução de um código personalizado (as famosas functions).

Não tem o porque reescrevermos a roda por aqui. Caso ainda tenha ficado alguma dúvida, este [artigo sobre o que é uma arquitetura serverlerss](https://medium.com/@dayvsonlima/voc%C3%AA-sabe-o-que-%C3%A9-arquitetura-serverless-1f6dd1184e5b) do Dayvson Lima pode ajudar.

## Monolitos vs Micro serviços

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/0*_73VNYOeSqDk_y84.png"/>
</div>

Arquitetura monolito vs micro serviços
De um lado da moeda temos a arquitetura monolítica, normalmente são grandes e complexas e todos os módulos do seu software ficam na mesma aplicação. Não necessariamente se utiliza uma única base de dados, mas não se assuste se assim encontrar. Com essa arquitetura temos que os monolitos são:

- Simples de desenvolver;
- Simples de testar;
- Simples de implementar;
- Alguns casos são complexos e difíceis de escalar;
- E a parte mais difícil, eles crescem e podem resultar em caos.

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/0*WQ_tX2yue3_kCDSf.jpg"/>
	<i>Monolito tende a causar problemas</i>
</div>

Do outro lado da moeda temos os micro serviços, que consistem em módulos isolados, cada um rodando na linguagem core do time que o mantém ou até a linguagem que irá resolver o problema de uma maneira melhor, utilizando base de dados dedicadas e distribuídas. Com essa arquitetura temos muitos beneficíos, porém o custo costuma ser maior. Vamos aos benefícios:

- Módulos desacoplados;
- Deploys mais rápidos e independentes;
- Diferentes linguagens e tipos de base de dados;
- Só que, mais complexidade (nem tudo são flores).
- Tá, por que você falou tudo isso? Simples pequeno gafanhoto, para ficarmos na mesma página.

## E o FaaS?

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/1*rUJvbf0srpg_WisZv24d6A.png"/>
</div>

Aqui entram os contêineres efêmeros que falamos anteriormente. Gostamos muito do gráfico acima, onde é mostrado a evolução do serverless e onde encaixa-se a arquitetura FaaS (Função como serviço). Entendemos que com as functions, os serviços devem possuir suas responsabilidades isoladas e você não precisará se preocupar com a escalabilidade dessas execuções. O provedor irá escalar até o infinito (na verdade, até o limite do seu cartão de crédito). Esta arquitetura também possui alguns benefícios:

- Servidores totalmente abstratos;
- Responsabilidade desacopladas;
- Auto escalonamento;
- Pode ser orientada a eventos;
- Possui um aumento de complexidade, onde muitas vezes é necessário uma mudança completa de mindset;
- E o melhor: só paga pelo que utilizar, já que seu sistema "hiberna" quando não utilizado.

A cereja do bolo desta arquitetura é sem dúvidas o custo. No caso da AWS Lambda, a cobrança é gerada pela quantidade de invocações e pelos Gigabytes de memória alocados por segundo de utilização. Em um próximo artigo, entrarei em detalhe sobre **como ter previsibilidade de custos**.

## Sobre a Reviewr

Para melhor compreensão, é importante você ter conhecimento sobre o que fazemos aqui na reviewr. [Aqui você encontra mais informações](http://reviewr.me/site/).

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/1*0ZrpBnNqEIPSlI6ZIsKBHw.png"/>
</div>

Alguns canais que recebem avaliações online (reviews)
A grosso modo: A reviewr faz gestão da reputação online de grandes marcas e seus estabelecimentos, através de um meio muito interessante: os famosos reviews. Com esses dados coletados e processados, centralizamos tudo em uma única plataforma, disponibilizando um sistema de gestão e publicação de respostas, indicadores e inteligência para os estabelecimentos.

O que nos levou a utilizar a arquitetura FaaS, foi a necessidade de diminuirmos o número de horas/dia de máquina e ainda assim, para que nosso sistema ficasse disponível a qualquer instante.

## 7 Lições Aprendidas

Vamos para a parte mais esperada (ou não). Trazemos as sete principais lições aprendidas nessa fase de reescrita e migração.

### Previsibilidade de Custos

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/1*1VAl9J4Vo2x-wP4kyHcA5A.png"/>
</div>

Como calcular o custo de uma AWS Lambda em produção
Com os recursos de FaaS, é possível prever quanto custará aproximadamente uma Lambda em produção. Você só precisa de 2 informações: quantidade de invocações e média do tempo de duração das execuções (para calcular quanto tempo você alocará de memória em gigabytes).

Vale ressaltar o **free-tier** que a Amazon disponibiliza para todos os seus clientes, no caso das Lambdas: 1 milhão de invocações e 400k Gb/s (créditos mensais).

### Disrupção da Mentalidade

É necessário mudar o pensamento quando se pensa de maneira mais granular. Neste contexto, nós pensamos em quebrar o máximo possível nossa arquitetura em responsabilidades e deixar de uma maneira simples, para que até um bebê consiga dar manutenção, reaproveitar código e subir uma nova função em produção em menos de três minutos (é o tempo de ferver a água do miojo).

### Versionamento e CI

Sem isso, trabalhar com funções será algo tão complexo que não fará sentido. Imagine só aquele mundo de funções com deploy manual, sem versionamento/documentação. Ou até mesmo aqueles repositórios enormes, cheios de funções, que pra fazer deploy de uma tem que fazer deploy de todas (meu Deus né?).

Aqui na reviewr, nossas funções são em **NodeJS** e **Golang**. Para todas, temos deploy automatizado com o CircleCI (fez merge do PR, está em prod meu amigo). Para o versionamento, utilizamos o semantic-release para os projetos em NodeJS e fazemos versionamento manual das functions em Golang (caso conheça algo, indique nos comentários). Como fica isso?

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/0*xPQHttxaAG3DNoWt"/>
	<i>Functions em NodeJS com pacotes NPM privados</i>
</div>

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/0*_bOZ6BtNjsVRjbcR"/>
	<i>Builds e deploys com CircleCI</i>
</div>

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/0*gNpnFZ6egTkssZ6M"/>
	<i>Semantic-release rodando lindo</i>
</div>

### Monitoramento e Alerta

Não poderíamos deixar de falar destes assuntos, não é mesmo? Aqui na reviewr, encontramos uma startup da Estónia que lançou o [Dashbird](http://dashbird.io/). O sistema deles integra com o seu **AWS Cloud Watch** e coleta todos os dados, métricas e indicadores. Ainda auxilia nos alertas, confira abaixo:

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/1000/1*YH6X2_AA33om-yIQb2SQtA.png"/>
	<i>Dashboard do Dashbird (é, usamos bastante FaaS por aqui)</i>
</div>

E além de você ter os seus alertas, você precisa confiar neles:

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/1*TrTaHWnIhRXy5Ro8ucG87A.png"/>
	<i>Slack alerts</i>
</div>

### Serviços Secundários

Este é um item que sofremos demais aqui ao migrar para a nova arquitetura. No primeiro dia, resolvemos fazer um teste de carga integrando todos os nossos estabelecimentos monitorados e foi catastrófico. Nossos bancos de dados caíram.

Você precisa muito tomar cuidado com os serviços ao redor da sua arquitetura. O provedor realmente irá executar suas funções de maneira paralela e você pode derrubar alguém nessa brincadeira (digamos que é um ataque contra si mesmo).

Aqui tivemos que utilizar o Kineses Firehose pra resolver o problema do Redshift (aqui chamamos o nosso cluster de Jarvis) e para o MongoDB, fizemos um cluster com **ReplicaSet**. Hoje lidamos com um master e seis slaves. Também tivemos que utilizar o projeto open-source [Restheart](https://restheart.org/) na frente do nosso cluster. Além dele isolar o driver para você, possui um **cache-in-memory** absurdo e gerencia o pool de conexões com o Mongo (pode usar para PostgreSQL também). A nossa dica é: cautela meu amigo.

### AWS Step Function

Este é mais para conhecimento, no decorrer dos nossos estudos, conhecemos este recurso da AWS (eles quase não tem recursos escondidos). O Step-function resolve o problema de gerenciamento e orquestração das functions. Ele é uma espécie de workflow que funciona como um middleware para você gerenciar as lambdas, que juntas, executam um fluxo específico.

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/800/0*9eASZU5hFyDkyBPn"/>
</div>

Você literalmente desenha (através de um JSON) o seu fluxo e o que ele deverá fazer, desde chamar uma lambda até validar um output de um evento.

Pode utilizar para fluxos pequenos e até para fluxos grandes/complexos.

Vale salientar algo: cuidado! O Step-function faz a cobrança por mudança de estado, tendo um custo de 0,0250 USD a cada 1k transições de estado (valores referentes a região da North Virgínia).

### Cold Start

É um estado que a função passa quando é iniciada pela primeira vez. O provedor provisiona um container para executa-la (como se aquecesse a função) e nas próximas chamadas (dentro de um período de tempo próximo) ele utiliza a que foi previamente aquecida. No nosso caso, chamamos a mesma função N vezes de maneira paralela, ou seja, todas ficam com o estado **cold-start** e isso impacta na duração da execução. E faz acontecer isso:

<div style="text-align:center">
	<img class="image" src="https://cdn-images-1.medium.com/max/1000/0*ebBghue8pb-Hx88x"/>
	<i>Lambdas em cold-start com durations consideravelmente altas</i>
</div>

Resolvemos de maneira parcial, configurando um cloud watch para ficar “conversando com as lambdas”. A cada 1min ele dispara um evento de PING para elas, onde validamos e respondemos um PONG \o/.

## Conclusão

A conclusão é que para usar funções no seu sistema depende muito do cenário da sua aplicação/arquitetura. De maneira geral, as lambdas podem resolver muitos problemas se forem bem utilizadas. É necessário um pensamento aguçado, simplista e disruptivo parar utilizar tudo o que elas podem oferecer.

Se você tiver dúvidas ou precisar de alguma coisa, pode me contactar pelo e-mail **leonardo.rifeli@reviewr.me** ou o Marcelo **marcelo.andrade@reviewr.me**.

Compartilhe as suas experiências com Serverless e FaaS nos comentários!
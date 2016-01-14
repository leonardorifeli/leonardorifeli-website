---
layout: post
title:  "Como trabalhar com custom annotations"
date: 2016-01-14
categories: Development
comments: false
author: Leonardo Rifeli
isResume: 1
resume:
---

Saudações méros mortais, primeiro, peço desculpas pelo período sem trazer novidades para você (estive em uma excursão pela galáxia :D), em breve escreverei um artigo sobre essa viagem.

Como meu amigo [Guilherme Diego](https://medium.com/@guidiego){:target="_blank"} disse no post dele ([Código Limpo é uma Responsabilidade — Blocos](https://medium.com/@guidiego/c%C3%B3digo-limpo-%C3%A9-uma-responsabilidade-blocos-5be1fdd8d341#.gbx5keq0s){:target="_blank"}):

{:.center}
![alt text](/img/posts/2016-01-custom-annotations/ler-curtir-compartilhar.png "Server MySQL Replication")

Em alguns projetos (rodando [Symfony2](https://symfony.com/){:target="_blank"}) em que participei do processo de **refactoring** o que me auxiliou foi a implementação de custom annotations, onde foi possível segregar informações e até atingir algumas práticas de **clean code**, salientando que, isso foi uma necessidade de alguns projetos.

Neste artigo eu não discutirei se é o correto, ou não (posso escrever sobre boas práticas nos próximos artigos), apenas demonstrarei como trabalhar com **custom annotations** com o **doctrine reader**. Fica sobre teu critério meu chapa!

## Introdução

teste

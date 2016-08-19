---
layout: post
title:  "Herança ou composição? Qual utilizar?"
date: 2016-08-19
categories: Development
subcategorie: Java
comments: true
author: Leonardo Rifeli
isResume: 1
resume: Atualmente, um dos assuntos mais abordados e importantes, na programação orientada a objetos, sendo, herança e Composição. Porém é visivel que muitos programados(as) optam por utilizar a herança sem mesmo validar as alternativas dentro de cada contexto.
---

Olá dev sapiens, desta vez o artigo será mais teórico (comparado ao último: [Web Socket no PHP](http://leonardorifeli.com/development/2016/05/29/socket-no-php.html)) e será sobre dois assuntos que possuem demasiada importância no meio da programação orientada a objetos, a herança e a composição.

Sim, na internet existem vários artigos sobre o assunto, porém, resolvi descrevê-lo do modo como eu os utilizo.

Enquanto escrevo este magnífico artigo, vou ouvindo um set **Progressive House** do **[Progressive House ](https://www.youtube.com/watch?v=N7DEv-QP_Zk){:target="_blank"}**.

## Herança ou composição? E agora, José?

{:.center}
![Composition](/img/posts/2016/08/19/composition.png){:style="width: 500px;"}

## Introdução

Atualmente, os assuntos mais abordados e importantes na programação orientada a objeto são herança e composição, porém, é visivel que muitos programados(as) optam por utilizar a herança sem mesmo validar as alternativas dentro de cada contexto.

Pois bem, este artigo tem como objetivo colocar os dois assuntos na balança, com o intuito de que você entenda do que cada um é composto e qual utilizar dentro de cada contexto/relação.

## Função

A herança e a composição são duas abordagens diferentes para obter-se a reutilização de funcionalidades.

## Herança

Na herança, uma classe herda (daí o termo herança) as propriedades e os métodos de sua classe-pai, de modo transitivo, ou seja, uma classe pode herdar de outra classe que herda de outra, até uma classe que não possuí uma classe-pai.

Com a herança, as propriedades e os métodos podem receber comportamentos diferentes na classe que herda a classe-pai, por uso da reescrita dos respectivos.

A herença deverá ser utilizada somente quando existir uma relação **"é-um"** no contexto. No exemplo abaixo, no arquivo **Car.java**, a classe **Car** herda a classe **Automobile** e nesse contexto temos uma relação **"é-um"**, ou seja, **Car** é um **Automobile**, em nenhum momento, **Car** deixará de se comportar como **Automobile**.

<script src="https://gist.github.com/leonardorifeli/d03e68ef59a0667a806952583c1ce978.js?file=Car.java"></script>
<span class="space">&nbsp;</span>

Verifique que a classe **Car.java** no exemplo acima, está sobrescrevendo o método **getColor()**, alterando o comportamento herdado da classe-pai **Automobile.java**.

<script src="https://gist.github.com/leonardorifeli/d03e68ef59a0667a806952583c1ce978.js?file=Automobile.java"></script>
<span class="space">&nbsp;</span>

Por fim, repare que, no contexto exemplificado acima, o ideal é utilizar a herança, pelo fato de ter-se uma relação **"é-um"**, podendo assim, atingir a reutilização dos comportamentos.

Com a evolução, poderíamos ter a classe **Truck.java** que também poderia herdar a classe **Automobile.java**, pelo fato de existir uma relação **"é-um"**, neste outro contexto.

## Composição

Na composição, codificamos pequenos comportamentos, onde uma classe irá apenas instanciar outra classe e utilizar uma propriedade ou um método (claro, os que estão expostos), com isso, podemos usar a composição para comportamentos mais complexos, podendo ainda, alterar a associação entre as classes em tempo de execução da aplicação.

De modo intuitivo, podemos definir a composição como quando uma classe usa um objeto (instância de outra classe) para proporcionar uma parte ou o todo em algum comportamento.

No exemplo abaixo, é utilizado a composição, pelo fato do contexto em questão possuir uma relação **"tem-um"**, onde a classe **Job.java** compoem a classe **People.java**. Neste contexto People pode possuir um Job e iniciá-lo.

Nem sempre uma pessoa irá possuir um emprego, por isso, existe uma relação **"tem-um"**, ou seja, usamos composição e não a herança.

<script src="https://gist.github.com/leonardorifeli/d03e68ef59a0667a806952583c1ce978.js?file=People.java"></script>
<span class="space">&nbsp;</span>

Repare que, o método construtor, instancia a classe **Job.java** somente se **People** possuir um emprego, com isso, podemos acionar o método **checkAndStartJob()** para iniciar o **job**.

Aqui temos uma relação **"tem-um"** e por isso utilizamos a composição. No exemplo acima, com a utilização da composição, podemos altera a classe em tempo de execução.

<script src="https://gist.github.com/leonardorifeli/d03e68ef59a0667a806952583c1ce978.js?file=Job.java"></script>
<span class="space">&nbsp;</span>

Classe **Job.java** e suas propriedades e métodos.

## Importância

A herança e a composição são de extrema imporância nas linguagens. Atualmente é raro encontrar linguagens que não as suportem. Caso contrário, seria quase impossível quebrarmos grandes solução em soluções pequenas/modulares.

Sem a reutilização de comportamentos/funcionalidades não teriámos códigos com responsabilidades únicas, que fazem somente uma coisa e fazem muito bem.

## Qual utilizar

Perceba, basta pensar antes de criar determinada solução, sempre tendo como objetivo, avaliar qual é a relação de um determinado problema. Em casos que exista uma relação **"é-um**, exemplos como: banana É uma fruta, carro É um automóvel, pássaro É uma ave etc. Nestes casos, utilize a herança.

Em casos que a relação tende a apenas propriedades, funcionalidades e/ou comportamentos específicos e possuí-se uma relação **"tem-um"** , exemplos: pessoa TEM a possibilidade de trabalhar, avião TEM a possibilidade de freiar etc, nestes casos, utilizamos a compoisição, aproveitando apenas uma parte (funcionalidade, propriedade, responsabilidade etc) de outra classe.

Pergunte-se sempre se em todo o clico de vida da aplicação e/ou do código, aquela relação será constante e imutável. Perceba no exemplo citado na relação da composição, a pessoa não **"é-um"** funcionário e não pode ser, pelo fato dessa relação ser mutável, imagine se a pessoa ficar desempregada. Por isso, uma pessoa **"tem-um"** papel de trabalho, por isso utiliza-se a composição.

Não use a herança apenas para obter-se a reunitilização de código, se não existe uma relação **"é-um"**, use a composição.

## Conclusão

Atualmente a composição é considerada superior à herança, pelo motivo de podermos mudar a associação entre classes em tempo de execução, podendo obter outros comportamentos. Com isso as aplicações se tornam mais reutilizáveis.

A herança traz consigo muitos benefícios, sendo o principal; a reutilização de código. Porém, ela traz também, alguns problemas como o acoplamento entre as classes.

A composição é utilizada em alguns padrões de projeto, fortalecendo a sua utilização, entre outros benefícios, está a manutenibilidade do código e da aplicação.

Portanto, utilize qual se encaixa na sua relação e no contexto do seu domínio.

Mêêoo, é isso, caso eu tenha esquecido de algo, adicione nos comentários, junto a sua opinião e seu ponto de vista sobre o assunto.

Abraços, dev.

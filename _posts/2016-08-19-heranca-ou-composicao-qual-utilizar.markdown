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

Um assunto muito abordado e importante na programação orientada a objetos é a utilização de herança ou composição, porém, é visível que muitos programadores(as) optam por utilizar a herança sem mesmo validar as alternativas dentro de cada contexto.

Pois bem, este artigo tem como objetivo colocar os dois assuntos na balança, com o intuito de que você entenda do que cada um é composto e qual utilizar dentro de cada contexto/relação.

## Função

A herança e a composição são duas abordagens diferentes para obter-se a reutilização de funcionalidades.

## Herança

Na herança, uma classe herda (daí o termo herança) as propriedades e os métodos de sua classe pai, de modo transitivo, ou seja, uma classe pode herdar de outra classe que herda de outra, até uma classe que não possuí uma classe pai.

Com a herança, as propriedades e os métodos podem se comportar de forma diferente na classe filha, por uso da reescrita dos respectivos métodos.

A herença deverá ser utilizada somente quando existir uma relação **"é-um"** no contexto. No exemplo abaixo, no arquivo **Car.java**, a classe **Car** herda a classe **Automobile** e nesse contexto temos uma relação **"é-um"**, ou seja, **Car** é um **Automobile**, em nenhum momento, **Car** deixará de se comportar como **Automobile**.

<script src="https://gist.github.com/leonardorifeli/d03e68ef59a0667a806952583c1ce978.js?file=Car.java"></script>
<span class="space">&nbsp;</span>

Verifique que a classe **Car.java** no exemplo acima, está sobrescrevendo o método **getColor()**, alterando o comportamento herdado da classe pai **Automobile.java**.

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

Aqui temos uma relação **"tem-um"** e por isso utilizamos a composição. No exemplo acima, com a utilização da composição, podemos alterar a classe em tempo de execução.

<script src="https://gist.github.com/leonardorifeli/d03e68ef59a0667a806952583c1ce978.js?file=Job.java"></script>
<span class="space">&nbsp;</span>

Classe **Job.java** e suas propriedades e métodos.

## Importância

A herança e a composição são de extrema importância nas linguagens. Atualmente é raro encontrar linguagens que não as suportem. Caso contrário, seria quase impossível quebrarmos grandes soluções em soluções pequenas/modulares.

Sem a reutilização de comportamentos/funcionalidades não teríamos códigos com responsabilidades únicas, que fazem somente uma coisa e fazem muito bem.

## Qual utilizar?

Avalie qual é a relação de um determinado problema. Em caso que exista uma relação **"é-um"** utilizamos a herança, exemplo: banana É uma fruta, carro É um automóvel, pássaro É uma ave etc.

Em casos que a relação tende a funcionalidades e/ou comportamentos específicos e possui uma relação **"tem-um"** , exemplos: pessoa TEM a possibilidade de trabalhar, avião TEM a possibilidade de freiar etc, nestes casos, utilize a composição, aproveitando apenas uma parte (funcionalidade, responsabilidade etc) de outra classe, utilizando o objeto.

Pergunte-se sempre se em todo o ciclo de vida da aplicação ou do código, aquela relação será constante e imutável. Um exemplo de avaliação: Em domínio onde **People** tem relação com **Employee**, neste caso deve-se utilizar a composição, pelo fato de ser algo mutável. Nem sempre **People** terá relação com **Employee**, e se a pessoa ficar desempregada? Portanto, neste caso, o uso da composição é mais adequado do que a herança.

Não use a herança apenas para obter a reutilização de código se não existe uma relação “é-um”. Nestes casos é mais apropriado utilizar a composição.

## Falando em Java

Apenas para abrir um parêntese no artigo, em Java, toda e qualquer classe possui uma herança, neste caso implicitamente. Toda classe em Java, sempre estenderá Object, com isso, alguns métodos são herdados.

Exemplo de herança com object, sobrescrevendo toString():

<script src="https://gist.github.com/leonardorifeli/d03e68ef59a0667a806952583c1ce978.js?file=String.java"></script>
<span class="space">&nbsp;</span>

Alguns métodos herdados da classe Object:

- clone();
- equals();
- toString();
- hashCode();
- entre outros.

Documentação da classe Object: [clique aqui](http://docs.oracle.com/javase/8/docs/api/java/lang/Object.html).

## Referências

- [Post de um amigo, Pedro Augusto](https://medium.com/@pedro.barros/heran%C3%A7a-ou-composi%C3%A7%C3%A3o-eis-a-quest%C3%A3o-7ce11fad4737#.ekombw2sy){:target="_blank"};
- [Composition vs. Inheritance: How to Choose?](https://www.thoughtworks.com/pt/insights/blog/composition-vs-inheritance-how-choose){:target="_blank"};
- [Herança versus Composição: qual utilizar?](http://www.devmedia.com.br/heranca-versus-composicao-qual-utilizar/26145){:target="_blank"};

## Conclusão

Atualmente a composição é considerada superior à herança, pelo motivo de podermos mudar a associação entre classes em tempo de execução, podendo obter outros comportamentos. Com isso as aplicações se tornam mais reutilizáveis.

A herança traz consigo muitos benefícios, sendo o principal; a reutilização de código. Porém, ela traz também, alguns problemas como o acoplamento entre as classes.

A composição é utilizada em alguns padrões de projeto, fortalecendo a sua utilização, entre outros benefícios, está a manutenibilidade do código e da aplicação.

Portanto, utilize qual se encaixa na sua relação e no contexto do seu domínio.

Mêêoo, é isso, caso eu tenha esquecido de algo, adicione nos comentários, junto a sua opinião e seu ponto de vista sobre o assunto.

Abraços, dev.

---
layout: post
title:  "Princípios SOLID: SRP e sopa de letrinhas"
date: 2017-03-20
categories: Development
subcategorie: Tip
comments: true
author: Leonardo Rifeli
isResume: 1
resume: este post abordarei sobre o primeiro dos 5 princípios, nomeados com o acrônimo **SOLID** após a popularização por Robert C. Margin (aka Uncle Bob).
---

Em programação de software a sigla **SOLID** tem ganhado cada vez mais importância. Trata-se de um acrônimo popularizado por **Robert C. Margin** (o Uncle Bob), onde cada letra representa um dos cinco princípios do OOD (object-oriented design) que, quando aplicados bem conjunto o  u isoladamente, possibilitam a criação de código fácil de manter e de se estender ao longo do tempo.

Esse é o primeiro post de uma série onde abordaremos todos os cinco princípios do **SOLID**. O primeiro é o "Single responsibility principle", abreviado por **SRP**, e significa literalmente "Princípio da Responsabilidade Única".

Para começar: falar de SOLID é falar de programação orientada a objetos e design (OOD). Tendo isso em mente, o Princípio de Responsabilidade única traz uma perspectiva diferente para a orientação a objeto: a **coesão**.

# Tá, e o que é coesão?

Segundo o dicionário online [Dicio](https://www.dicio.com.br/coesao/):

> - Cujas partes estão ligadas harmonicamente entre si: coesão do governo.
União; harmonia; associação íntima: a coesão das partes de um Estado.
> - Uso correto dos aspectos gramaticais que conectam os elementos de um texto, tornando-o claro e compreensível.
> - [Figurado] Coerência de pensamento; fundamento que dá sentido a uma obra.
Aderência; força que une as moléculas e/ou átomos às partes constituintes de um corpo, fazendo com que eles não se partam.
> (Etm. do francês: cohésion)

Fonte: [dicio.com.br/coesao](https://www.dicio.com.br/coesao/).

E no mundo do desenvolvimento de software, o que é coesão?

Algo que faça sentido para alguém. E este alguém, é quem irá consumir uma determinada classe e seus métodos. Cada participante deve ter somente um propósito para existir. Ou seja, coesão é consequência de ter-se um bom design e não violar SRP.

##### E as vantagens de ter-se alta coesão (ou "coesão forte"):

Redução da complexidade das classes e métodos (eles são mais simples, com menos operações).

# Definição de responsabilidade

Segundo o dicionário online [Dicio](https://www.dicio.com.br/responsabilidade/):

> - Obrigação; dever de arcar, de se responsabilizar pelo próprio comportamento ou pelas ações de outra(s) pessoa(s).
> - [Por Extensão] Sensatez; competência para se comportar de maneira sensata.
> - Natureza ou condição de responsável; capacidade de responder por seus próprios atos; qualidade de quem presta contas as autoridades.
> - [Jurídico] Obrigação jurídica que resulta do desrespeito de algum direito, através de uma ação contrária ao ordenamento jurídico.

Fonte: [dicio.com.br/responsabilidade](https://www.dicio.com.br/responsabilidade/).

E no contexto de um código?

**Robert C. Martin**, define responsabilidade como: **uma classe deve ter apenas uma razão para ser alterada**.

Seguindo a definição, temos que, se uma classe está focada em uma única funcionalidade, ela terá apenas uma preocupação e uma única razão para ser alterada.

# Problemas da violação do SRP

Se uma classe possui mais que uma razão para ser alterada, entende-se que ela possui mais que uma responsabilidade, tornando-a desconexa (não coesa).

#### Quais problemas uma classe não coesa poderá causar para a aplicação?

- Dificuldade no reuso de suas responsabilidades;
- Dificuldades na manutenção (dificuldade em manter e/ou evoluir por conta do excesso de responsabilidades);
- Aumento na rigidez e fragilidade: quando alterar uma responsabilidade, outra pode ser comprometida;
- Alto acoplamento da classe.

# Exemplos

Os códigos dos exemplos serão exibidos somente com as assinaturas, para reforçar a idéia que **Uncle Bob** traz, de que a implementação dos métodos é irrelevante para a análise. Somente com as assinaturas, conseguimos perceber se existe (ou não) a violação do princípio.

#### Exemplo 1

Considere o arquivo abaixo, onde temos a classe **`PopulationStandardDeviation`** e a sua responsabilidade é calcular o desvio padrão populacional.

```java
package com.leonardorifeli.article;

public class PopulationStandardDeviation {

    public double mean() { }
    public double calculate() { }
    public double deviationSumSquare() { }

}
```

Perceba que, o nome da classe diz exatamente qual é a sua responsabilidade, calcular o desvio padrão populacional.

Com o exemplo acima, podemos ver rapidamente a violação do princípio, onde ela expõem o método **`mean()`** e quem implementa esta classe não espera que ela faça cálculo da média. Apesar da média fazer parte do algoritmo para calcular o **desvio padrão populacional**, ela não faz parte da responsabilidade da classe, logo, a exposição do método **`mean()`** mesmo fazendo parte do algoritmo, viola o princípio. O método **`mean()`** não deveria ser exposto. Mesmo problema com o método **`deviationSumSquare()`**.

Neste caso, para que não haja a violação do príncipio, deve-se deixar ambos os métodos (**`mean()`** e **`deviationSumSquare()`**) como **`private`** ou subir eles para cada classe, injetando esta dependência na **`PopulationStandardDeviation`**.

#### Exemplo 2

Neste segundo exemplo, considere o arquivo abaixo, onde temos a classe **`Report`** e a sua responsabilidade é gerar relatório.

```java
package com.leonardorifeli.article;

public class Report {

    public ArrayList<String> find() { }
    public ArrayList<String> proccess() { }
    public void print() { }

}
```

O nome da classe também diz exatamente qual a sua responsabilidade, gerar relatório.

Mas, vamos refletir. Na visão do usuário, gerar relatório é apenas fazer com que os dados sejam exibidos em tela (ou impressos), de modo organizado. No nível de desenvolvimento de software, gerar relatório engloba vários fatores, sendo eles: buscar os dados, processá-los, organizá-los e exibi-los em tela (ou impressos).

Perceba que para gerar relatório envolvem várias responsabilidades. A classe **`Report`** possui várias razões para ser alterada, mudar o método **`find()`** para buscar os dados em outro lugar ou, mudar o método **`proccess()`** para alterar uma regra de domínio e até mesmo alterar o método **`print()`**.

Perceba que para gerar um relatório, várias funcionalidades são envolvidas, fazendo com que a classe **`Report`** possua várias responsabilidades distintas, violando **`SRP`**. Com isso, existem algumas razões para ela ser alterada, por exemplo: poderíamos mudar o método **`find()`** para consultar os dados em outro repositório, alterar uma regra de negócio no método **`proccess()`** e até mesmo alterar o método **`print()`**.

##### Como poderíamos melhorar essa classe?

Inicialmente, precisaríamos isolar o método **`find()`** em um contexto de repositório (outra classe que faça somente a busca dos dados no banco). Depois, poderíamos isolar o método **`proccess()`** noutra classe e que teria apenas uma responsabilidade, processar os dados que vieram do banco de dados e tratá-los de acordo com o domínio em questão. Finalmente, deixaremos a classe **`Report`** com a injeção das suas dependências, tendo somente o método **`generate()`**.

# Referências

- [Livro - Agile Software Development, Principles, Patterns, and Practices](https://www.amazon.com/dp/0135974445/);
- [Article Cohesion - Computer Science](https://en.wikipedia.org/wiki/Cohesion_(computer_science);
- [SOLID Principles with Uncle Bob - Robert C. Martin](http://www.hanselminutes.com/145/solid-principles-with-uncle-bob-robert-c-martin);
- [Robert C Martin The Single Responsibility Principle](https://www.youtube.com/watch?v=dzawoPISdHc).

# Conclusão

O SRP é um dos princípios mais importantes da orientação a objetos. Atentando-se a ele, seus códigos ficarão mais coesos, simples e manuteníveis. É um princípio bem extenso e os exemplos tendem ao infinito.

Podemos continuar as discussões sobre este princípio nos comentários?

Compartilhe conosco seus aprendizados.

# Agradecimentos

A ContaAzul, por proporcionar o espaço e me dar a oportunidade de compartilhar meu conhecimento.
Ao **Leonardo Camacho**, pelo auxílio nas correções e incentivo para escrever.
Para Carlos Becker, Lucas Merencia, Marcos Ferreira, Marcelo Ed. Junior e Jeferson Kersten pelo incentivo e auxílio dos assuntos aqui descritos.

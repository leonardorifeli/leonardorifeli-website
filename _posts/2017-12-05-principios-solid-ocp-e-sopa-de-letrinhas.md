---
layout: post
title:  "Princípios SOLID: OCP e sopa de letrinhas"
date: 2017-12-05
categories: [development, solid]
author: leonardorifeli
comments: true
featured: true
hidden: true
image: https://cdn-images-1.medium.com/max/800/1*mZg735tK49B6LDzk7UvIrQ.jpeg
---

Este é o segundo post de uma série onde abordaremos todos os cinco princípios do SOLID. Neste, falaremos sobre "Open closed principle", abreviado por OCP, e significa literalmente "Princípio aberto-fechado".

O primeiro post foi sobre "Single responsibility principle", abreviado por SRP, e você pode [ler aqui](http://leonardo.rifeli.tech/development/2017/03/20/principios-solid-srp-e-sopa-de-letrinhas.html).

Para começar: falar de SOLID é falar de programação orientada a objetos e design (OOD). Tendo isso em mente, o princípio aberto-fechado traz uma perspectiva importante: os participantes precisam ser abertos para extensão e fechadas para modicação.

# Antes de tudo, os conceitos SOLID estão atrelados?

De maneira ou outra, sim! No primeiro post, discutimos sobre [SRP](http://leonardo.rifeli.tech/development/2017/03/20/principios-solid-srp-e-sopa-de-letrinhas.html) onde os participantes devem possuir somente uma razão para mudança; adicionar uma nova feature irá violar tanto SRP como OCP. Ou seja, quanto maior o número de responsabilidade de um participante, maior a probabilidade de violar OCP.

Portanto, um código que segue SRP tende a estar mais próximo de seguir OCP, por consequência.

# Tá! E o que é ser aberto para extensão?

Após um software estar em produção, há grande probabilidade de sofrer alterações, evoluir, ter novas features, etc. OCP defende que à partir do momento que o software está em produção, os participantes em questão não poderão sofrer modificações, diminuindo a chance de algum bug ser causado.

Aberto para extensão significa que não podemos modificar o participante que já está em produção e sim exterder as suas funcionalidades atuais e implementar as novas features.

Ou seja, o OCP nos força a desenvolver códigos extensíveis, tornando-os escaláveis e não editáveis.

Com isso, é importante ter a definição de herança bem clara. Você pode ler um pouco sobre no artigo [Herança ou Composição](https://leonardo.rifeli.tech/development/2016/08/19/heranca-ou-composicao-qual-utilizar.html).

# Problemas da violação do OCP

- Quebrar outros princípios SOLID;
- Maior probabilidade de causar bug;
- Um código não escalável e provavelmente menos extensível;
- Entre outros.

# Exemplos

Seguindo o mesmo padrão do primeiro post, os exemplos serão exibidos somente com as assinaturas, para refornçar a ideia que *Uncle Bob* traz, de que a implementação dos métodos é irrelevante para a análise. Somente com as assinaturas, conseguimos perceber se existe (ou não) a violação do princípio.

#### Exemplo com violação

Observe o exemplo abaixo, onde temos a classe *`Debit`* e ela precisará debitar um determinado valor de um tipo de débito.

```php
<?php

namespace Leonardo\Rifeli\Article\Business;

use namespace Leonardo\Rifeli\Article\Business\DebitType;

class Debit
{
    public function execute(int value, DebitType debitType) { }
}

?>
```

Com o exemplo acima, será necessário ter condições para controlar e implementar as regras de negócio dos tipos de débitos. Considerando que tenhamos os tipos: *`Savings`* e *`CheckingAccount`*, teríamos condições para estes dois tipos e caso novos tipos de détibo surgem, violaríamos OCP.

#### Exemplo sem violação

No exemplo abaixo, a classe *`Debit`* virará uma *`abstract class`*, e os tipos de conta, serão classes derivadas de *`Debit`*.

```php
<?php

namespace Leonardo\Rifeli\Article\Business\Abstract;

abstract class Debit
{
    abstract public function execute(int value) { }
}

?>
```

Caso novos tipos de débito surgem, basta extender *`Debit`* e executar a transação com as regras de negócio necessárias.

Com isso, a cada novo tipo, teremos novos códigos e não códigos alterados.

```php
<?php

namespace Leonardo\Rifeli\Article\Business;

use Leonardo\Rifeli\Article\Business\Abstract\Debit;

class CheckingAccount extends Debit
{
    public function execute(int value) { }
}

?>
```

Para ampliar nossos exemplo, podemos criar uma classe *`SomeDebit`* tendo os métodos *`setDebit`* e *`execute`*, conforme exemplo abaixo.

```php
<?php

namespace Leonardo\Rifeli\Article\Business;

use Leonardo\Rifeli\Article\Business\Abstract\Debit;

class SomeDebit
{
    private $debit;

    public function setDebit(Debit $debit)
    {
        $this->debit = $debit;
    }

    public function execute(int value)
    {
        return $this->debit->execute(value);
    }
}

?>
```

Conforme novos tipos forem surgindo, basta criá-lo extendendo *`Debit`*, e utilizar o *`SameDebit`* para executar. Aqui, no final, estamos aplicando o padrão de projeto *`Strategy`*.

# Referências

- [Livro - Agile Software Development, Principles, Patterns, and Practices](https://www.amazon.com/dp/0135974445/);
- [Hangout sobre OOD - Princípio Open Closed](https://www.youtube.com/watch?v=LsA4QRwq58o&list=PLRX4OtWY_G7N518US48x-EZxXt6h0pr3V&index=2);
- [OOD - Open Closed Principle](https://pt.slideshare.net/MayogaX/ood-princpio-openclosed);
- [SOLID Principles with Uncle Bob - Robert C. Martin](http://www.hanselminutes.com/145/solid-principles-with-uncle-bob-robert-c-martin);
- [Design Patterns GoF](https://en.wikipedia.org/wiki/Design_Patterns);
- [SOLID part 2 - The Open Closed Principle](https://code.tutsplus.com/pt/tutorials/solid-part-2-the-openclosed-principle--net-36600);
- [Strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern);
- [PHP do jeito certo - Design Patterns](http://br.phptherightway.com/pages/Design-Patterns.html);
- [Casa do Código - Orientação a Objetos e SOLID para Ninjas](https://www.casadocodigo.com.br/products/livro-oo-solid).

# Conclusão

OCP reforça que pensar em orientação a objetos é pensar primeiro na abstração e depois na implementação em si.
Vale lembrar que softwares OO evoluem por meio de novos códigos, e não por edições.

Podemos continuar as discussões sobre este princípio nos comentários?

Compartilhe seus aprendizados.
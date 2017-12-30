---
layout: post
title:  "Princípios SOLID: LSP e sopa de letrinhas"
date: 2017-12-30
categories: Development
subcategorie: Tip
comments: true
author: Leonardo Rifeli
---
Este é o terceiro post de uma série onde abordaremos todos os cinco princípios do SOLID. Neste, falaremos sobre "Liskov substitution  principle", abreviado por LSP, e significa literalmente "Princípio da substituição de Liskov".

- O primeiro post foi sobre "Single responsibility principle", abreviado por SRP, e você pode [ler aqui](http://leonardo.rifeli.tech/development/2017/03/20/principios-solid-srp-e-sopa-de-letrinhas.html).
- O segundo post foi sobre "Open closed principle", abreviado por OCP, e você deve [ler aqui](http://leonardo.rifeli.tech/development/2017/12/05/principios-solid-ocp-e-sopa-de-letrinhas.html).

![alt text](http://leonardo.rifeli.tech/img/posts/2016-01-custom-annotations/ler-curtir-compartilhar.png "Share the post.")

Para começar: falar de SOLID é falar de programação orientada a objetos e design (OOD). Tendo isso em mente, o princípio de substituição de Liskov traz outra perspectiva importante: classes filhas nunca deveriam inflingir as definições de tipo da classe pai.

# Contexto histórico

Este conceito foi apresentado por [Barbara Liskov](https://pt.wikipedia.org/wiki/Barbara_liskov) numa conferência em 1987, e depois foi publicado em um artigo científico, com o nome, [`Family Values: A Behavioral Notion of Subtyping`](http://reports-archive.adm.cs.cmu.edu/anon/1999/CMU-CS-99-156.ps), junto de [Jeannette Wing](https://en.wikipedia.org/wiki/Jeannette_Wing), em 1993. Com a seguinte definição original:

> Se q(x) é uma propriedade demonstrável dos objetos x de tipo T. Então q(y) deve ser verdadeiro para objetos y de tipo  S onde S é um subtipo de T.

E após a publicação do livro [Agile Software Development, Principles, Patterns, and Practices](https://www.amazon.com/dp/0135974445/), está definição ficou conhecida como Princípio de Substituição de Liskov. O que nos leva para a definição de Uncle Bob:

> Subclasses devem ser substituíveis pelas classes base.

Simples, uma subclasse deve poder sobrescrever os métodos da classe base, de modo com que não quebre suas funcionalidades, do ponto de vista do cliente.

# Problemas da violação do LSP

- Geração de problemas na classe cliente (pariticipante que está consumindo outro participante);
- Comportamentos inesperados no software por suposições equivocadas;
- Quebra de outros princípios.

# Exemplo

Seguindo o mesmo padrão do primeiro e segundo post, os exemplos (com exceções de alguns participantes) serão exibidos somente com as assinaturas, para reforçar a ideia que Uncle Bob traz, de que a implementação dos métodos é irrelevante para a análise. Somente com as assinaturas, conseguimos perceber se existe (ou não) a violação do princípio.

Neste post, usaremos o clássico exemplo do `quadrado` e do `retângulo`.

#### Exemplo do quadrado e retângulo

No participante abaixo, temos a classe `Rectangle` e ela compõe as propriedades de um retângulo, sendo `width` (largura) e `height` (altura).

```php
namespace Leonardo\Rifeli\Article; 

class Rectangle
{

    private $width;
    private $height;

    public function getWidth() { }
    public function getHeight() { }
    public function setWidth($width) { }
    public function setHeigth($heigth) { }

}
```

Abaixo temos a classe `RectangleArea`, responsável por efetuar o cálculo da área de um `Rectangle`.

```php
namespace Leonardo\Rifeli\Article; 

use Leonardo\Rifeli\Article\Rectangle;

class RectangleArea
{

    // calc rectangle area: $rectangle->getWidth() * $rectangle->getHeight().
    public function calc(Rectangle $rectangle) { }

}
```

Até aqui tudo dentro do esperado. Temos dois participantes (`Rectangle` e `RectangleArea`) e eles funcionam como esperado, pelo menos, por enquanto.

Vamos escrever agora um teste para nossos participantes (neste caso teremos implementação para as coisas não ficarem tão abstrato).

```php
namespace Leonardo\Rifeli\Article\Test; 

use Leonardo\Rifeli\Article\Rectangle;
use Leonardo\Rifeli\Article\RectangleArea;

class TestRectangleArea
{

    const WIDTH = 10;
    const HEIGHT = 5;

    public function testCalc(Rectangle $rectangle) 
    {
        $rectangle->setWidth(self::WIDTH);
        $rectangle->setHeight(self::HEIGHT);

        $rectangleArea = new RectangleArea();

        if($rectangleArea->calc($rectangle) !== (self::WIDTH * self::HEIGHT))
            throw new \Exception('Violated LSP.');
    }

}
```

A ideia deste teste não é testar a unidade e sim mostrar que ao passar uma derivação o teste será quebrado. E vale ressaltar que a orientação a objetos não é composta de unidade e sim por participantes que se relacionam através de seus comportamentos.

Portanto, todos os testes que fizermos para o `Rectangle` irão passar e nossa aplicação estará funcionando conforme o esperado. Mas, o software evolui e a extensão precisará ocorrer. Consideramos que nossa aplicação está em utilização por vários clientes e precisaremos agora manipular quadrados.

Na geometria, um quadrado é um tipo especial de retângulo, então poderemos criar um participante `Square` que derive o `Rectangle`.

Teríamos o seguinte (também com as implementações para melhor compreensão).

```php
namespace Leonardo\Rifeli\Article; 

use Leonardo\Rifeli\Article\Rectangle;

class Square extends Rectangle
{

    public function setWidth($width) 
    {
        parent::setWidth($width);
        parent::setHeigth($width);
    }
    
    public function setHeigth($heigth) 
    {
        parent::setWidth($height);
        parent::setHeigth($height);
    }

}
```

Uma observação, perceba que precondição do participante `Square` é **mais forte** que da `Square`. Em um quadrado, ambos os lados precisam ser iguais.

Agora vamos entender o todo, vamos executar o teste unitário.

```php
namespace Leonardo\Rifeli\Article\Square;

use Leonardo\Rifeli\Article\Rectangle;
use Leonardo\Rifeli\Article\Square;
use Leonardo\Rifeli\Article\Test\TestRectangleArea;

$rectangle = new Rectangle();
$square = new Square();
$test = new TestRectangleArea();

$test->testCalc($rectangle);
$test->testCalc($square);
```

Ressaltando, aqui estamos tratando com testes unitários, mas a orientação a objetos não é composta por unidade e sim participantes e seus comportamentos.

Para o teste do `Square`, uma excessão será lançada. Se passar valores de altura e largura iguais, o teste passará normalmente. Matematicamente, um quadrado é um retângulo. Aqui estamos com relação de herança `é-um` e em orientação a objetos, por comportamento, um quadrado não é um retângulo.

Por isso viola LSP, dificilmente substituímos a subclasse pela base para analisar se o comportamento ainda será o mesmo, sem quebrar o cliente.

# Referências

- [Hangout sobre OOD - Princípio da Substituição de Liskov](https://www.youtube.com/watch?list=PLRX4OtWY_G7N518US48x-EZxXt6h0pr3V&time_continue=397&v=QJB1jp8bReY)
- [SOLID - Liskov Substitution Interface Segregation Principles](https://code.tutsplus.com/pt/tutorials/solid-part-3-liskov-substitution-interface-segregation-principles--net-36710)
- [SOLID Principles with Uncle Bob - Robert C. Martin](http://www.hanselminutes.com/145/solid-principles-with-uncle-bob-robert-c-martin);
- [Casa do Código - Orientação a Objetos e SOLID para Ninjas](https://www.casadocodigo.com.br/products/livro-oo-solid).

# Conclusão

LSP reforça que devemos pensar muito antes de sairmos implementando os participantes. Nem sempre o que escrevemos com base nas definições dos comportamentos, serão o que são, em orientação a objetos.

Podemos continuar as discussões sobre este princípio nos comentários?

Compartilhe seus aprendizados.
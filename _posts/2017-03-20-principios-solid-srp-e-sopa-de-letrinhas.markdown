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

Neste post irei abordar sobre o primeiro, de 5 princípios, que passaram a ser chamados pelo acrônimo SOLID após a popularização por [**Robert C. Margin (aka Uncle Bob)**](cleancoder.com). Estes princípios fazem parte do livro [**Agile Software Development, Principles, Patterns, and Practices**](https://www.amazon.com.br/dp/0135974445/ref=asc_df_01359744454899280?smid=A1ZZFT5FULY4LN&tag=goog0ef-20&linkCode=asn&creative=380341&creativeASIN=0135974445).

# O que este acrônimo representa?

![image](http://www.csharpstar.com/wp-content/uploads/2016/01/SOLID.jpg)

Estes princípios nos ajudam a manter um código coeso e de fácil manutenibilidade.

Neste post falaremos sobre o princípio **SRP** (princípio da responsabilidade única).

SRP tem uma perspectiva diferente para a orientação a objeto, a **coesão**.

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

Algo que faça sentido para alguém, e este alguém, é quem irá consumir uma determinada classe e seus participantes. Cada participante deve ter somente um propósito para existir, sendo então, coeso.

# Definição de responsabilidade

Robert C. Martin, define responsabilidade como: **uma classe deve ter apenas uma razão para ser alterada**.

Seguindo a definição, temos que, se uma classe está focada em uma única funcionalidade, ela terá apenas uma preocupação e uma única razão para ser alterada.

Não se prenda em entender esta definição de imediato, pois nos exemplos isto ficará mais claro e legível.

# Problemas da violação do SRP

Se uma classe possui mais que uma razão para ser alterada, entende-se que ela possui mais que uma responsabilidade, tornando-a desconexa (não coesa).

#### Quais problemas uma classe não coesa poderá causar para a aplicação?

- Dificuldade no reuso de suas responsabilidades;
- Dificuldades na manutenabilidade;
- Aumento na rigidez e fragilidade: quando alterar uma responsabilidade, outra pode ser comprometida;
- Alto acoplamento da classe.

A quebra deste princípio pode atrapalhar diretamente a durabilidade do software no ciclo de desenvolvimento.

# Exemplos

Nos exemplos, mostrarei a violação apenas com as assinaturas dos métodos, para reforçar a idéia que **Uncle Bob** traz, de que a implementação dos métodos é irrelevante para a análise. Somente com as assinaturas, conseguimos perceber se existe (ou não) a violação do princípio.

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

Perceba que para gerar relatório envolvem várias resposabilidades. A classe **`Report`** possuí várias razões para ser alterada, mudar o método **`find()`** para buscar os dados em outro lugar ou, mudar o método **`proccess()`** para alterar uma regra de domínio e até mesmo alterar o método **`print()`**.

Perceba que para gerar um relatório, várias funcionalidades são envolvidas, fazendo com que a classe **`Report`** possua várias responsabilidades distintas, violando **`SRP`**. Com isso, existem algumas razões para ela ser alterada, por exemplo: poderíamos mudar o método **`find()`** para consultar os dados em outro repositório, alterar uma regra de negócio no método **`proccess()`** e até mesmo alterar o método **`print()`**.

##### Como poderíamos melhorar essa classe?

Inicialmente, precisaríamos isolar o método **`find()`** em um contexto de repositório (outra classe que faça somente a busca dos dados no banco). Depois, poderíamos isolar o método **`proccess()`** noutra classe e que teria apenas uma responsabilidade, processar os dados que vieram do banco de dados e tratá-los de acordo com o domínio em questão. Finalmente, deixaremos a classe **`Report`** com a injeção das suas dependências, tendo somente o método **`generate()`**.

# Conclusão

O SRP é um dos princípios mais importantes da orientação a objetos. Atentando-se a ele, seus códigos ficarão mais coesos, simples e manuteníveis. É um princípio bem extenso e os exemplos tendem ao infinito.

Podemos continuar as dicussões sobre este princípio nos comentários.

Compartilhe conosco seus aprendizados.

# Agradecimentos

A ContaAzul, por proporcionar o espaço e me dar a oportunidade de compartilhar meu conhecimento.
Ao **Leonardo Camacho**, pelo auxilio nas correções e incentivo para escrever.
Para Carlos Becker, Lucas Merencia, Marcos Ferreira, Marcelo Ed. Junior e Jeferson Kersten pelo incentivo e auxílio dos assuntos aqui descritos.

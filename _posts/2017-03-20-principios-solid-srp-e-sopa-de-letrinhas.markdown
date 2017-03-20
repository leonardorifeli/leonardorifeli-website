---
layout: post
title:  "Princípios SOLID: SRP e sopa de letrinhas"
date: 2017-03-20
categories: Development
subcategorie: Tip
comments: true
author: Leonardo Rifeli
isResume: 1
resume: Neste post irei abordar sobre o primeiro princípio, um dos 5 princípios que passaram a ser chamados pelo acrônimo SOLID após a popularização por Robert C. Margin (aka Uncle Bob).
---

Neste post irei abordar sobre o primeiro princípio, um dos 5 princípios que passaram a ser chamados pelo acrônimo SOLID após a popularização por [**Robert C. Margin (aka Uncle Bob)**](cleancoder.com), estes princípios fazem parte do livro [**Agile Software Development, Principles, Patterns, and Practices**](https://www.amazon.com.br/dp/0135974445/ref=asc_df_01359744454899280?smid=A1ZZFT5FULY4LN&tag=goog0ef-20&linkCode=asn&creative=380341&creativeASIN=0135974445). Mas, o que este acrônimo representa? Isto é explicado na imagem abaixo.

![image](http://www.csharpstar.com/wp-content/uploads/2016/01/SOLID.jpg)

Quando bem aplicados, estes princípios, nos ajudam a evitar um código não coeso e com difícil manutenibilidade.

Neste post falaremos sobre o princípio **SRP** (princípio da responsabilidade única).

Este princípio é uma perspectiva diferente para os princípios de orientação a objeto, sendo esta perspectiva a **coesão**.

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

Algo que faça sentido, fazer sentido é fazer sentido para alguém. E este alguém é quem irá consumir uma determinada classe e seus participantes. Cada participante deve ter somente um propósito para existir, isto é ter coesão.

# Definição de responsabilidade

Vou utilizar alguns contextos para expor esta definição de modo agradável e que faça sentido.

O Robert C. Martin diz que responsabilidade é **uma classe ter somente uma única razão para ser alterada**. Tendo apenas uma razão para ser alterada, podemos concluir que neste ponto, teremos uma classe que seja focada em uma funcionalidade somente, pois se esta cobre apenas uma funcionalidade, terá apenas uma preocupação e uma única razão para ser alterada.

Não prenda-se em entender esta definição primeiramente, nos exemplos isto ficará mais claro e legível.

# Problemas da violação do SRP

Uma classe que possua mais que uma razão para ser alterada, possui mais do que uma responsabilidade, contudo, não é uma classe coesa. Quais problemas uma classe não coesa poderá causar para a aplicação?

- Problemas no reuso de suas responsabilidades;
- Dificuldades na manutenabilidade;
- Aumento na rigidez e fragilidade: quando alterar uma responsabilidade, outra pode ser comprometida, ou seja, a aplicação não terá rigidez e poderá quebrar outros participantes que a consomem, sendo algo frágil.
- Alto acoplamento da classe.

A quebra deste princípio pode atrapalhar diretamente a durabilidade do software no ciclo de desenvolvimento.

# Exemplos

Inicialmente, mostrarei a violação apenas com as assinaturas dos métodos, podendo então, reforçar a ideia que **Uncle Bob** traz, que a implementação dos métodos é irrelevante para a análise, somente com as assinaturas podemos saber se existe a violação do princípio.

#### Exemplo 1

Considere o arquivo abaixo, onde temos a classe **`PopulationStandardDeviation`** e a sua responsabilidade é calcular o desvio padrão populacional.

<script src="https://gist.github.com/leonardorifeli/cceb88b6490a135892a780510abe4e60.js?file=PopulationStandardVariation.java"></script>

Perceba que, o nome da classe diz exatamente qual é a sua responsabilidade, calcular o desvio padrão populacional.

Com o exemplo acima, podemos ver rapidamente a violação do princípio, onde ela expõem o método **`mean()`** e quem implementa esta classe não espera que ela faça cálculo da média. Apesar da média fazer parte do algoritmo para calcular o **desvio padrão populacional**, ela não faz parte da responsabilidade da classe, logo, a exposição do método **`mean()`** mesmo fazendo parte do algoritmo, viola o princípio. O método **`mean()`** não deveria ser exposto. Mesmo problema com o método **`deviationSumSquare()`**.

Neste caso específico, para não violar o príncipio deve-se deixar ambos os métodos como **private** ou subir eles para cada classe e injetando esta dependência na **PopulationStandardDeviation**.

#### Exemplo 2

Neste segundo exemplo, considere o arquivo abaixo, onde temos a classe **`GenerateReport`** e a sua responsabilidade é gerar relatório.

<script src="https://gist.github.com/leonardorifeli/cceb88b6490a135892a780510abe4e60.js?file=GenerateReport.java"></script>

O nome da classe também diz exatamente qual a sua responsabilidade, gerar relatório.

Mas, vamos refletir, gerar relatatório na visão do usuário é apenas fazer os dados serem exibidos em tela ou impressos, de modo organizado. No nível do desenvolvimento de software, gerar relatório engloba vários fatores, sendo eles: buscar os dados, processá-los e organizá-los e exibi-los em tela ou impressos.

Perceba que para gerar relatório envolvem várias resposabilidades. A classe **`GenerateReport`** possuí várias razões para ser alterada, mudar o método **`find()`** para buscar os dados em outro lugar ou, mudar o método **`proccess()`** para alterar uma regra de domínio e até mesmo alterar o método **`print()`**.

Claramente a classe está violando o princípio, e como podemos corrigir isto?

Neste contexto precisaríamos inicialmente isolar o método **`find()`** em um contexto de repositório (outra classe que faz somente a busca de dados no banco de dados, por exemplo). Depois isolar método **`proccess()`** em uma classe **`ProccessReport`** por exemplo, onde ele irá somente processar os dados que vieram do banco de dados e tratá-los de acordo com o domínio em questão e retorná-los. Finalmente, deixaremos a classe **`GenerateReport`** com a injeção das suas dependências e tendo somente o método **`generate()`**, por exemplo, que irá receber o retorno do processo dos dados e imprimir o resultado do relatório.

# Conclusão

O SRP é um dos princípios mais importantes da orientação a objetos, atentando-se a ele, seus códigos ficarão mais coesos, simples e manuteníveis.

É um princípio bem extenso e os exemplos tendem ao infinito, os exemplos aqui apresentados são bem simples para melhor entendimento. Isso não nos impede de continuarmos as dicussões sobre este princípio nos comentários.

Compartilhe conosco os aprendizados.

# Agradecimentos

Aqui vão meus humildes agradecimentos a ContaAzul por proporcionar-me esta oportunidade de poder compartilhar conhecimento.

Em especial ao Leonardo Camacho pelo auxílio nas correções e incentivo para escrever. Também ao Carlos Becker e Lucas Merencia pelo incentivo e auxílio dos assuntos aqui descritos.
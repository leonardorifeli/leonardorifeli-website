---
layout: post
title:  "Web Socket no PHP"
date: 2016-05-29
categories: [development, websocket, php]
comments: true
author: leonardorifeli
---

Olá homo sapiens, desta vez o artigo será um pouco mais técnico. Falarei sobre **web socket com PHP**, claro, também com Javascript.

Enquanto escrevo este magnífico artigo, vou ouvindo um **Tech House** do **[Trevor Nygaard](https://www.youtube.com/watch?v=qhmf1PnLvlw){:target="_blank"}**.

Bom, segue a primeira dica; o artigo será bem extenso, ou seja, corra e pegue uma caneca com muito café (o elixir da vida) e vem comigo que será bem divertido.

{:.center}
![Need coffee](https://media.giphy.com/media/6heBQSjt2IoA8/giphy.gif "Need Coffee")

## Introdução

Atualmente a web possuí um tema que é pouco estudado e há poucos artigos e informações na internet. O respectivo tema é **web socket**. Acredito que o tema é pouco falado, devido a sua complexidade. Portanto, não darei uma abordagem profunda neste artigo, será na prática, uma introdução.

## Objetivo

Este artigo tem como objetivo, descrever uma breve introducão teórica e prática sobre web socket.

## Pauta

Neste artigo, acompanharemos a pauta abaixo:

1. suporte dos navegadores;
2. um breve resumo sobre HTTP;
3. o que é web socket;
4. sobre o Ratchet;
5. exemplo e detalhes;
6. casos de uso;
7. conclusão.

## 1. Navegadores

Sim, eles devem ser um grande ponto de atenção, não são todos os navegadores que dão suporte a **web socket**, você deve avaliar este ponto antes de qualquer outro. Para isso, o site [caniuse](http://caniuse.com/#feat=websockets) informa todos os navegadores bem como suas respectivas versões que possuem suporte a web socket. Como atalho, os navegadores e versões são esboçados na figura abaixo.

{:.center}
![Suporte dos navegadores](/img/posts/2016/05/11/support-websocket.png "Suporte dos navegadores")

Como você observou, dependendo do seu público, este tópico não será uma pedra no seu sapato.

## 2. Um pouco sobre HTTP

Atualmente as requisições HTTP funcionam da seguinte maneira: o navegador abre uma porta de comunicação em um domínio específico, envia uma solicitação de cabeçalho HTTP para o servidor (apache ou nginx), o servidor envia a mensagem para a aplicação, que por sua vez, processa as informações, gera um documento (**HTML**, **JSON**, **XML** etc) e envia o respectivo documento para o servidor. Em seguida, o servidor adiciona os cabeçalhos HTTP apropriados para a requisição, envia de volta para o navegar e encerra a conexão.

Mais informações: [Wikipedia](https://pt.wikipedia.org/wiki/Hypertext_Transfer_Protocol#M.C3.A9todos_de_solicita.C3.A7.C3.A3o){:target="_blank"}

E o socket, como funciona? Veja abaixo.

## 3. O que é Web Socket?

Web Sockets são um full-duplex, conexão persistente **bi-direcional** de um navegador web para um servidor. Depois que uma conexão socket é estabelecida a conexão permanece aberta até que o cliente ou servidor decide encerrar. Com esta conexão aberta, o cliente ou servidor pode enviar uma mensagem a qualquer outro cliente conectado.  Sendo assim, neste momento, uma única aplicação de servidor em execução estará ciente de todas as conexões abertas, o que lhe permite comunicar com qualquer outra conexão aberta e a qualquer momento.

Adicional:

>Web Socket foi desenvolvido para ser implementado em browsers web e servidores web, mas pode ser usado por qualquer cliente ou aplicação servidor. O protocolo Websocket é um protocolo independente baseado em TCP. Sua única relação com o HTTP é que seu handshake é interpretado por servidores HTTP como uma requisição de upgrade.
Fonte: [Wikipedia](https://pt.wikipedia.org/wiki/WebSocket){:target="_blank"}

## 4. Sobre o Ratchet

As aplicações de socket para servidor não tem acompanhado os navegadores. É aí que surgiu o **Ratchet**, uma ferramenta fantástica para a implementação de um servidor, por protocolo **TCP**. Você pode iniciar um servidor com o **Ratchet I/O Component Server**, tendo um código que implementa o respectivo componente e poderá gerenciar todas as conexões.

Fluxo de uma conexão:

{:.center}
![Fluxo de funcionamento](/img/posts/2016/05/11/RatchetFlow.png "Fluxo de funcionamento")

## 5. OK, Show me the code!

{:.center}
![Fluxo de funcionamento](https://media.giphy.com/media/ZVik7pBtu9dNS/giphy.gif "Fluxo de funcionamento"){:style="width: 50%"}

Como um amigo (o [Lucas Teles](https://www.facebook.com/lucasvst?fref=ts){:target="_blank"}) sempre fala nos eventos, **show me the code**, apresenta o código cara! No exemplo que irei demonstrar (com base na documentação do Ratchet), iremos seguir as implementações abaixo:

- dependência do ratchet;
- recursos para o servidor de socket;
- o gerenciador de conexões;
- consumir o web socket, utilizando o lindo Javascript.

## 5.1 A Dependência

Sim, iremos utilizar uma dependência, afinal, quem vive sozinho?

<script src="https://gist.github.com/leonardorifeli/037db591223698b96379935a2379f6b7.js?file=composer.json"></script>
<span class="space">&nbsp;</span>

Como você pode observar no arquivo **composer.json**, é requerido a dependência **"cboden/ratchet": "0.3.*"**.

## 5.2 Implementando o servidor

Analise o código abaixo, nele é implementado os recursos do Ratchet.

<script src="https://gist.github.com/leonardorifeli/037db591223698b96379935a2379f6b7.js?file=server.php"></script>
<span class="space">&nbsp;</span>

O que é implementado no arquivo **server.php**, é explicado abaixo:

1. **Ratchet\Server\IoServer**: Cria um socket aberto para escutar uma porta específica, para conexões de entrada. Os eventos são delegados através deste para as aplicações anexadas.
2. **Ratchet\Http\HttpServer**: Implementa os métodos da interface **MessageComponentInterface** e gerencia as conexões.
3. **Ratchet\WebSocket\WsServer**: Um adaptador para lidar com as requisições e respostas do web socket. Este é o mediador entre o servidor e o cliente, para lidar com as mensagens em tempo real, por intermédio de um navegador web.
4. **Hermes\Business\Service\SocketService**: Este será nosso gerenciador de conexões, mensagens, erros e encerramentos.

Dos itens que serão implementados, só entrarei em detalhes sobre o item quatro, do qual realmente nos interessa. Caso tenha curiosidade, procure como cada item funciona.

## 5.3 Gerenciador das conexões

Muito bem, o código abaixo, será o gerenciador das conexões, mensagens, encerramentos e erros.

<script src="https://gist.github.com/leonardorifeli/037db591223698b96379935a2379f6b7.js?file=SocketService.php"></script>
<span class="space">&nbsp;</span>

Como pode-se observar, a classe **SocketService** implementa a interface **MessageComponentInterface** e possui os métodos: **__construct(), onOpen(), onMessage(), onClose(), onError()**. Bem como, o atributo estático; **$connections**.

Vamos falar sobre a responsabilidade de cada método. Primeiro, o construct; ao iniciar o servidor (explicado no tópico 5.2), o atributo estático $connections, recebe uma instância de **SplObjectStorage** e será responsável por armazenar todas as conexões.

**onOpen()**: É o método executado a cada nova conexão, nele você poderá resgatar informações da conexão, como: sala, nome etc, enviadas pelo protocolo GET. O método depende do serviço **[ConnectionInformationService](#connectionInformationService)** (exibido abaixo), que será o responsável por tratar as informações recebidas, via GET e retorna em um objeto. Ao receber o objeto, o método envia uma mensagem ao método **getNewUser()** ao serviço **UserService** requisitando uma nova instância de **user** e a adiciona ao storage de objetos.

### <a name="connectionInformationService"></a> O serviço Connection Information

<script src="https://gist.github.com/leonardorifeli/037db591223698b96379935a2379f6b7.js?file=ConnectionInformationService.php"></script>
<span class="space">&nbsp;</span>

O serviço em questão, verifica os parâmetros enviados por GET e valida se o parâmetro **name** e **room** foram informados.

PS.: O serviço **UserService**, pode ser visualizado [clicando aqui](https://gist.github.com/leonardorifeli/037db591223698b96379935a2379f6b7#file-userservice-php){:target="_blank"}.

**onMessage()**: Este método é executado, sempre que, um cliente envia uma mensagem ao servidor, dependendo do domínio da aplicação, a mensagem poderá ser transferida para conexões da mesma sala ou para todas as conexões. No exemplo em questão, a mensagem é transferida para as conexões que estão na mesma sala do remetente.

**onClose()**: Sempre que uma conexão for encerrada, o método removerá a conexão do storage de objetos.

**onError()**: Este método é para fins bem exclusivos, depende do domínio da aplicação, ele será executado sempre que uma conexão lançar uma exceção. Neste caso, a conexão é finalizada pelo servidor. 

## Consumindo o web socket.

Para consumir o servidor de web socket, será utilizado o construtor **WebSocket**. Conforme o exemplo abaixo.

<script src="https://gist.github.com/leonardorifeli/037db591223698b96379935a2379f6b7.js?file=server.js"></script>
<span class="space">&nbsp;</span>

**Repare o ws:** Há um novo esquema de URL para conexões Web Socket. Existe também **wss:** para uma conexão Web Socket é usado para conexões HTTP seguras.

Com isso, você pode manipular mensagens para o servidor e, ele por sua vez, repassar para outras conexões.

## Casos de uso

Sempre que precisar de uma conexão quase em tempo real de baixa latência entre o cliente e o servidor, você terá que implementar Web Socket. Isso pode envolver a reformulação do modo como você desenvolve as aplicações de servidor com um novo foco em tecnologias como filas de eventos. 

Alguns exemplos de casos de uso:

* usuários editando um mesmo registro;
* chats;
* links que precisam de rápida atualização;
* jogos on-line de vários players;
* atualização em tempo real de redes sociais.

## Referências

* [Apresentando WebSockets: trazendo soquetes para a web](http://www.html5rocks.com/pt/tutorials/websockets/basics/){:target="_blank"}
* [Gist Completo](https://gist.github.com/leonardorifeli/037db591223698b96379935a2379f6b7){:target="_blank"}
* [Introduction to WebSockets](http://socketo.me/docs){:target="_blank"}

## Conclusão

Chegamos a um ponto de tecnologias e exigências, onde, as aplicações estão cada vez mais complexas, mais inteligêntes, mais isoladas de acordo com suas responsabilidades. O tema do qual eu escrevi está sendo utilizado cada vez mais nas aplicações que necessitam de atualizações instantâneas de informações. 

Vale muito perder um tempo estudando e projetando. Um dia, você desenvolvedor, irá precisar de Web Socket.

Tem algo para incrementar? Utilize os comentários abaixo, agregue valor para a comunidade. Quaisquer críticas construtivas, serão bem-vindas.



---
layout: post
title:  "Docker: Vamos falar sobre virtualização"
date: 2016-11-05
categories: Development
subcategorie: Docker
comments: true
author: Leonardo Rifeli
isResume: 1
resume: No desenvolvimento de aplicações, podemos optar por usar máquinas virtuais (VMs) para facilitar o gerenciamento e provisionamento de serviços. Para isso, podemos citar o [Vagrant](https://www.vagrantup.com/). Mas, o provisionamento de máquinas virtuais demanda grande quantidade de tempo, além do fato do consumo demasiado de espaço em disco, recursos em geral da máquina que será o host.
---

## Sumário

- Introdução;
- Um pouco sobre virtualização;
- O que é Docker;
- O que é um contêiner;
- Namespaces;
- Algumas vantagens do Docker;
- Principais funcionalidades;
- Docker image;
- Dockerfile;
- Docker compose;
- Referências;
- Conclusão.

## Introdução

Sim, eu fiquei alguns meses sem escrever! Sorry!

Sem ressentimentos, o assunto deste artigo é muito importante. Falaremos sobre virtualização, isso mesmo. Sim, eu sei que se fôssemos descrevê-lo em muitos detalhes, levaríamos longos e diversos artigos. Portanto, o objetivo deste artigo é trazer um "resumão" sobre este assunto. Falarei sobre **virtualização tradicional**, **virtualização por contêineres** e apresentarei o **[Docker](https://www.docker.com/)** (caso não o conheça).

O objetivo deste artigo é descrever as teorias por volta do tema, farei um segundo artigo, que será um **na prática** com o Docker.

Sem mais delongas, chega mais que vai ser muito foda!

## Pegue um café

Corre lá e pegue um pouco de café, o assunto será bem interessante.

{:.center}
![get your coffee](/img/posts/2016/11/03/get-coffee.gif){:style="width: 400px;"}

## Um pouco sobre Virtualização

No desenvolvimento de aplicações, podemos optar por usar máquinas virtuais (VMs) para facilitar o gerenciamento e provisionamento de serviços. Para isso, podemos citar o [Vagrant](https://www.vagrantup.com/). Mas, o provisionamento de máquinas virtuais demanda grande quantidade de tempo, além do fato do consumo demasiado de espaço em disco, recursos em geral da máquina que será o host.

Assim surgiu o [LXC](https://en.wikipedia.org/wiki/LXC). O Linux Container, ou LXC, foi lançado em 2008 e é uma tecnologia que permite a crianção de múltiplas instâncias isoladas de um determinado sistema operacional. Ou seja, uma maneira de virtualizar aplicações dentro de uma máquina (hospedeira) usando todos os recursos disponíveis no mesmo Kernel da máquina
hospedeira.

Tendo como precursor, o comando [chroot](https://en.wikipedia.org/wiki/Chroot), que foi lançado em 1979 pelo [Unix V7](https://en.wikipedia.org/wiki/Version_7_Unix), como intuito de segregar acessos de diretórios e evitar que os usuários possam acessar à estrutura raiz **(/)**. Este conceito evoluiu alguns anos, com o lançamento do comando [jail](https://www.freebsd.org/cgi/man.cgi?query=jail&sektion=8&manpath=freebsd-release-ports), no SO [FreeBSD 4](https://www.freebsd.org/releases/4.0R/announce.html).

Com relação à virtualização, a diferença está no fato do **LXC** não necessitar de uma camada de sistema operacional para cada aplicação. Como você pode verificar na imagem abaixo.

{:.center}
![vms vs contêineres](/img/posts/2016/11/03/contêiner-structure.png){:style="width: 80%;"}

Ao compararmos o **LXC** com a **virtualização tradicional**, fica mais claro que uma aplicação sendo executada em um LXC demanda muito menos recursos, consumindo menos espaço em disco e com um nível de portabilidade muito mais abrangente.

## O que é o Docker?

{:.center}
![docker](/img/posts/2016/11/03/docker.png)

Nasceu como um projeto da [DotCloud](https://cloud.docker.com/), uma empresa **PaaS** (Platform as a Service).

Basicamente, Docker é uma plataforma open-source, escrita em **Go**, tendo como finalidade, criar e gerenciar ambientes isolados para aplicações. O Docker garante que, cada contêiner tenha tudo que uma aplicação precise para ser executado.

Em outras palavras, o Docker é uma ferramenta de empacotamento de uma aplicação e suas dependências em um contêiner virtual que pode ser executado em um servidor linux.

## Então, Docker é uma VM?

Não, contêineres docker possuem uma arquitetura diferente, que permite maior portabilidade e efeciência.

{:.center}
![docker](/img/posts/2016/11/03/docker-system.png){:style="width: 100%;"}

## Tecnologias e ideias utilizadas

Cara, contêiner não é nada novo, Docker surgiu para facilitar o uso deles. Abaixo um resumo de tecnologia e o ano da primeira versão:

{:.center}
![docker](/img/posts/2016/11/03/technologies-year.png){:style="width: 50%;"}

## O que é um contêiner?

Vamos fazer uma comparação prática. Container nada mais é que uma caixa de metal, onde é colocado tudo o que couber. Containers possuem dimensões e interfaces comuns, onde guindastes e guinchos podem ser acoplados para colocá-los em navios ou caminhões.

A virtualização em contêineres é muito mais leve, onde, temos cada contêiner como uma instância isolado em um kernel de sistema operacional. Os contêineres possuem interfaces de redes virtuais, processos e sistemas de arquivos independentes.

Algumas características de um conteiner Docker:

- Dependende de uma imagem (falaremos logo abaixo);
- Geram novas imagens;
- Conectividade com o host e outros contêineres;
- Execuções controladas, CPU, RAM, I/O, etc.

## Namespaces

O Docker utiliza os recursos de [Namespaces](https://en.wikipedia.org/wiki/Namespace) para dispor um espaço de funcionamento isolado para os contêineres. Contudo, quando um contêiner é criado, também é criado um conjunto de namespaces e este, por sua vez, cria uma camada para isolamento para os grupos de processos. Abaixo seguem os tipos de namespaces:

- **PID:** isolamento de processos.
- **NET:** controle de interfaces de rede.
- **IPC:** controle dos recursos de IPC (InterProcess Communication).
- **MNT:** gestão de pontos de montagem.
- **UTC (Unix Timesharing System):** provém todo o isolamento de recursos do kernel (justamente a camada de abstração como mostra a imagem).

## Algumas Vantagens do Docker

- Baixo overhead e tempo de boot;
- Kernel compartilhado com o Host;
- Containers rodam isoladamente;
- Facilidade de configuração do ambiente de desenvolvimento de novos membros do time;
- Acabar com a história do "na minha máquina funcionava";

## Principais Funcionalidades

- **Versionamento**: O Docker permite que você versione as alterações de um contêiner. Isto permite verificar as diferenças entre versões, fazer commit de novas versões e fazer rollback.
- **Compartilhamento de imagens**: Sim, existe um repositório de contêineres, o **Docker Hub** possui milhares de contêineres com as mais diversas aplicações instaladas. Você pode rapidamente criar sua aplicação com uma base já desenvolvida, ou ainda criar sua base e compartilhá-la na comunidade.
- **Licença open-source**: Licenciado como Apache License 2.0, mantém os códigos fonte disponíveis para facilitar o desenvolvimento colaborativo.
- **Hardware**: Exige poucos recursos de processos, memória e espaço em disco.
- **Comunicação entre contêineres**: Conectar contêineres via mapeamentos de porta **TCP/IP** não é a única forma de disponibilizar recursos entre eles.

E uma das principais:

{:.center}
![docker](/img/posts/2016/11/03/dependency-hell.png){:style="width: 30%;"}

- **Evita Dependency Hell**: Um dos maiores problemas que os desenvolvedores de software convivem, é o gerenciamento de dependências. O Docker evita problemas neste gerenciamento.

## Docker Image

Uma imagem Docker, nada mais é que, um arquivo inerte, imutável, que é essencialmente instanciado por um contêiner. As imagens são criadas com o comando **build** (entrarei em mais detalhes na segunda parte do artigo) e elas serão consumidas por um contêiner, ou seja, um contêiner é a instância de uma imagem. Como as imagens podem ser muito grandes, as imagens são projetadas para serem compostas por camadas de outras imagens.

Basicamente, uma imagem é um conjunto de camada que você descreve, quando você inicia uma imagem, você terá um contêiner em execução desta imagem e você pode ter muitos contêineres da mesma imagem. Portanto, uma imagem em execução é um contêiner.

E como criar uma imagem, ou seja, como descrever as camadas de uma imagem? Chega mais...

## Dockerfile

Bom, basicamente, **Dockerfile** é um arquivo (ah vá!) que contém um conjunto de instruções necessárias para se criar uma imagem **Docker**, ou seja, se você tiver o Dockerfile de uma imagem, basta modificar o que deseja e recriar a imagem "do zero", sim, isso pode demorar um pouco mais, mas essa imagem será muito mais "enxuta".

Caso não tenha o **Dockerfile** (geralmente você irá cair neste caso), você pode usar uma imagem à sua escolha como base e então criar a sua imagem como uma camada acima.

Exemplo de Dockerfile:

```
FROM image[:tag] # de qual imagem irá se basear
RUN command # o que será executado por um shel (ex: apt-get update)
WORKDIR /src # diretório "raiz" para os comandos seguintes
COPY . /src # copia arquivos para dentro do contêiner
VOLUME /src # volumes compartilhados
EXPOSE 8080 # porta liberada para fora do contêiner
CMD [command, params]
```

Alguns links:

- [Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
- [Docker Explained: Using Dockerfiles to Automate Building of Images](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images)
- [Exemplos de Dockerfile](https://github.com/kstaken/dockerfile-examples)
- [Exemplo - Dockerfile do Mongodb](https://github.com/kstaken/dockerfile-examples/blob/master/mongodb/Dockerfile)

## Docker Compose

Basicamente, é uma ferramenta para a criação e execução de múltiplos contêineres de aplicação.

Você utiliza um arquivo do tipo **yaml** para definir como será o ambiente de sua aplicação. Sua aplicação não é sozinha, ela poderá depender de serviços como: banco de dados, redis, php, java, etc (que estará em outro contêiner), imagine ter que subir todos estes contêineres (detalhe, antes de ter que subir o contêiner da sua aplicação). O Docker Compose irá facilitar isso. Ele é ótimo para desenvolvimento, testes e homologação, bem como para melhorar seu fluxo de integração continua. Por exemplo:

- **Ambiente de desenvolvimento**: você pode simular todo o ambiente de produção, ou seja, precisando de outros serviços (conforme citado acima), basta definir isso em um arquivo .yml e quando você executar o Docker Compose, todo esse ambiente estará disponível para você.

[Documentação oficial](https://docs.docker.com/compose/)

## Gado vs Animal de Estimação

Pense bem nessa diferença. A sua infraestrutura deve ser composta de componentes que você possa tratar como gado: **auto-suficientes**, **facilmente substituíveis** e **gerenciáveis**.

Isso mesmo, não se apegue aos seus contêineres, eles podem subir, serem replicados, destruídos e gerenciados com uma flexibilidade muito maior.

## Referências

- [Ebook - Docker for the virtualization admin](https://goto.docker.com/rs/929-FJL-178/images/Docker-for-Virtualization-Admin-eBook.pdf)
- [Como Instalar e Utilizar o Docker: Primeiros passos](https://www.digitalocean.com/community/tutorials/como-instalar-e-utilizar-o-docker-primeiros-passos-pt)
- [Docs about Docker](https://docs.docker.com/)
- [Infoslack - Docker](https://infoslack.com/docker/)
- [Hugo Posca - Nivelando conhecimento](http://www.slideshare.net/HugoPosca/talk-31-dockernivelandoconhecimento)
- [Hugo Posca - Docker Compose](http://www.slideshare.net/HugoPosca/talk-32-docker-compose)
- [LinuxTips - Docker Tutorial #1 - Docker, Containers, Images e muito mais!](https://www.youtube.com/watch?v=0cDj7citEjE)

## Conclusão

Bom, estou ciente que foi um post grande (comparado aos anteriores), talvez até um pouco cansativo, mas é muito importante que se entenda a teoria para praticar. Publicarei outro post, com um conteúdo mais da prática e alguns exemplos, claro, com Docker meu amigo.

Peço que comentem sobre o que acharam deste artigo, o que esperam da segunda parte, enfim, qualquer feedback será importante para o desenvolvimento dos outros artigos.

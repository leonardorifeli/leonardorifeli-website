---
layout: post
title:  "Docker: Vamos falar sobre virtualização"
date: 2016-10-31
categories: Development
subcategorie: Docker
comments: true
author: Leonardo Rifeli
isResume: 1
resume: No desenvolvimento de aplicações, podemos optar por usar máquinas virtuais (VMs) para facilitar o gerenciamento e provisionamento de serviços. Para isso, podemos citar o Vagrant. Mas, o provisionamento de máquinas virtuais demanda grande quantidade de tempo, além do fato do consumo demasiado de espaço em disco, recursos em geral, da máquinas que será o host.
---

## Sumário

- Introdução;
- Um pouco sobre virtualização;
- O que é Docker;
- Principais funcionalidades;
- Dockerfile;
- Docker image;
- Docker compose;
- Orquestração de contêineres.

## Introdução

Sim, eu fiquei alguns meses sem escrever! Sorry!

Sem ressentimentos pois o assunto deste artigo é muito importante. Falaremos sobre virtualização, isso mesmo. Eu sei que se fôssemos descreve-lo em detalhes, levaríamos longos e diversos artigos. Portanto, o objetivo deste artigo é trazer um "resumão" sobre este assunto. Abordaremos sobre **virtualização tradicional**, **virtualização por containers** e apresentarei o **[Docker](https://www.docker.com/)** (caso não o conheça).

Sem mais delongas, chega mais que vai ser muito foda!

## Pegue um café

Corre lá e pegue um pouco de café, o assunto será bem interessante.

{:.center}
![get your coffee](/img/posts/2016/10/31/get-coffee.gif){:style="width: 400px;"}

## Um pouco sobre Virtualização

No desenvolvimento de aplicações, podemos optar por usar máquinas virtuais (VMs) para facilitar o gerenciamento e provisionamento de serviços. Para isso, podemos citar o [Vagrant](https://www.vagrantup.com/). Mas, o provisionamento de máquinas virtuais demanda grande quantidade de tempo, além do fato do consumo demasiado de espaço em disco, recursos em geral, da máquinas que será o host.

Assim surgiu o [LXC](https://en.wikipedia.org/wiki/LXC). O Linux Container, ou LXC, foi lançado em 2008 e é uma tecnologia que permite a crianção de múltiplas instâncias isoladas de um determinado sistema operacional. Ou seja, uma maneira de virtualizar aplicações dentro de uma máquina (hospedeira) usando todos os recursos disponíveis no mesmo Kernel da máquina
hospedeira.

Tendo como precursor, o comando [chroot](https://en.wikipedia.org/wiki/Chroot), que foi lançado em 1979 pelo [Unix V7](https://en.wikipedia.org/wiki/Version_7_Unix), como intuito de segregar acessos de diretórios e evitar que os usuários possam acessar à estrutura raiz **(/)**. Este conceito evoluiu alguns anos, com o lançamento do comando [jail](https://www.freebsd.org/cgi/man.cgi?query=jail&sektion=8&manpath=freebsd-release-ports), no SO [FreeBSD 4](https://www.freebsd.org/releases/4.0R/announce.html).

Com relação à virtualização, a diferença está no fato do **LXC** não necessitar de uma camada de sistema operacional para cada aplicação. Como você pode verificar na imagem abaixo.

{:.center}
![vms vs containers](/img/posts/2016/10/31/container-structure.png){:style="width: 80%;"}

Ao compararmos o **LXC** com a **virtualização tradicional**, fica mais claro que uma aplicação sendo executada em um LXC demanda muito menos recursos, consumindo menos espaço em disco e com um nível de portabilidade muito mais abrangente.

## E o que é o Docker?

{:.center}
![docker](/img/posts/2016/10/31/docker.png)

Nasceu como um projeto da [DotCloud](https://cloud.docker.com/), uma empresa **PaaS** (Platform as a Service).

Basicamente, Docker é uma plataforma open-source, escrita em **Go**, tendo como finalidade, criar e gerenciar ambientes isolados para aplicações. O Docker garante que, cada container tenha tudo que uma aplicação precise para ser executado.

Em outras palavras, o Docker é uma ferramenta de empacotamento de uma aplicação e suas dependências em um container virtual que pode ser executado em um servidor linux.

## Então, Docker é uma VM?

Não, containers docker possuem uma arquitetura diferete, que permite maior portabilidade e efeciência.

{:.center}
![docker](/img/posts/2016/10/31/docker-system.png){:style="width: 100%;"}

## O que é um container?

Nada mais é que uma caixa de metal, onde é colocado tudo o que couber. Containers possuem dimensões e interfaces comuns, onde guindastes e guinchos podem ser acoplados para colocá-los em navios ou caminhões.

## Algumas Vantagens do Docker

- Baixo overhead e tempo de boot;
- Kernel compartilhado com o Host;
- Containers rodam isoladamente;
- Facilidade de configuração do ambiente de desenvolvimento de novos membros do time;
- Acabar com a história do "na minha máquina funcionava";

## Principais Funcionalidades

- **Contêineres portáveis**: você consegue criar uma imagem contendo toda a configuração e código, instalar em um contêiner e transferir/instalar em um outro host.
- **Versionamento**: Docker permite que você versione as alterações de um contêiner. Isto permite portanto verificar as diferenças entre versões, fazer commit de novas versões e fazer rollback de uma dada versão.
- **Reutilização de componentes**: As imagens criadas podem ser reutilizadas, como por exemplo, se diversas de suas aplicações utilizam um stack com Java 8, Tomcat 8 e Oracle 12 você poderá criar uma uma imagem base contendo estes itens com sua instalação e configuração. Desta maneira esta imagem poderá ser reutilizada em diversos Contêineres diferentes. Podemos construir imagens Docker usando um arquivo Dockerfile e o comando de montagem docker build.
- **Compartilhamento**: O Docker Hub já possui milhares de contêineres com as mais diversas aplicações instaladas e configuradas, desta maneira você pode rapidamente criar sua aplicação com uma base desenvolvida por outra pessoa, ou ainda criar sua base e compartilhá-la.
- Automatização de Implantação dentro dos Contêineres: Usando os provisionadores que por sua vez usam a API do Docker, podemos automatizar a implantação dos ambientes de software.
- Licença Open Source: Licenciado como Apache License, Version 2.0 mantém os códigos fonte disponíveis para facilitar o desenvolvimento colaborativo.
- Evita Dependency Hell: Um dos maiores problemas em múltiplos ambientes com os quais os desenvolvedores de software convivem diariamente é o gerenciamento de dependências. O Docker evita problemas neste gerenciamento.
- Demanda Poucos Recursos de Hardware: Exige poucos recursos de processos, memória e espaço em disco.
- Ligação entre Contêineres: Conectar contêineres via mapeamentos de porta TCP/IP não é a única forma de disponibilizar recursos entre eles. Um contêiner Docker pode se conectar a um outro via um sistema de ligação e enviar informações de um para o outro de forma eficiente e segura. Quando os contêineres estão ligados, a informação sobre o contêiner origem pode ser enviada para um contêiner destino.

## Na prática

## Docker File

## Docker image

## Docker Compose

### História

Em 2013, a empresa Orchard iniciou um projeto chamado Fig.
Em 2014, foram adquiridos pela empresa Docker Inc.
Eis que nasce o Docker Compose

Escalar aplicação
docker-compose scale app=5

Kubernetes
Ambientes clusterisados

### Solução

## Ensinamentos filosóficos

mount points

Gado vs Animais de Estimação

A sua aplicação não vive sozinha, ela depende de outras aplicações.

## Referências

- [Ebook - Docker for the virtualization admin](https://goto.docker.com/rs/929-FJL-178/images/Docker-for-Virtualization-Admin-eBook.pdf)

## Conclusão

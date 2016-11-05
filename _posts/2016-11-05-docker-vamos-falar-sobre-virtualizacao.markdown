---
layout: post
title:  "Docker: Vamos falar sobre virtualização"
date: 2016-11-04
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
- O que é um contêiner;
- Namespaces;
- Algumas vantagens do Docker;
- Principais funcionalidades;
- Docker image;
- Docker file;
- Docker compose;
- Referências;
- Conclusão.

## Introdução

Sim, eu fiquei alguns meses sem escrever! Sorry!

Sem ressentimentos pois o assunto deste artigo é muito importante. Falaremos sobre virtualização, isso mesmo. Eu sei que se fôssemos descreve-lo em detalhes, levaríamos longos e diversos artigos. Portanto, o objetivo deste artigo é trazer um "resumão" sobre este assunto. Abordaremos sobre **virtualização tradicional**, **virtualização por contêineres** e apresentarei o **[Docker](https://www.docker.com/)** (caso não o conheça).

Sem mais delongas, chega mais que vai ser muito foda!

## Pegue um café

Corre lá e pegue um pouco de café, o assunto será bem interessante.

{:.center}
![get your coffee](/img/posts/2016/11/03/get-coffee.gif){:style="width: 400px;"}

## Um pouco sobre Virtualização

No desenvolvimento de aplicações, podemos optar por usar máquinas virtuais (VMs) para facilitar o gerenciamento e provisionamento de serviços. Para isso, podemos citar o [Vagrant](https://www.vagrantup.com/). Mas, o provisionamento de máquinas virtuais demanda grande quantidade de tempo, além do fato do consumo demasiado de espaço em disco, recursos em geral, da máquinas que será o host.

Assim surgiu o [LXC](https://en.wikipedia.org/wiki/LXC). O Linux Container, ou LXC, foi lançado em 2008 e é uma tecnologia que permite a crianção de múltiplas instâncias isoladas de um determinado sistema operacional. Ou seja, uma maneira de virtualizar aplicações dentro de uma máquina (hospedeira) usando todos os recursos disponíveis no mesmo Kernel da máquina
hospedeira.

Tendo como precursor, o comando [chroot](https://en.wikipedia.org/wiki/Chroot), que foi lançado em 1979 pelo [Unix V7](https://en.wikipedia.org/wiki/Version_7_Unix), como intuito de segregar acessos de diretórios e evitar que os usuários possam acessar à estrutura raiz **(/)**. Este conceito evoluiu alguns anos, com o lançamento do comando [jail](https://www.freebsd.org/cgi/man.cgi?query=jail&sektion=8&manpath=freebsd-release-ports), no SO [FreeBSD 4](https://www.freebsd.org/releases/4.0R/announce.html).

Com relação à virtualização, a diferença está no fato do **LXC** não necessitar de uma camada de sistema operacional para cada aplicação. Como você pode verificar na imagem abaixo.

{:.center}
![vms vs contêineres](/img/posts/2016/11/03/container-structure.png){:style="width: 80%;"}

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

## Docker image

## Docker File

Dockerfile é um arquivo que contém um conjunto de instruções necessárias para se criar uma imagem Docker, ou seja, com posse do Dockerfile de uma determinada imagem, basta modificar o que deseja e recriar a imagem "do zero".

Isso pode demorar um pouco mais, mas essa imagem será muito mais "enxuta" e você terá controle total do seu estado, o que seria bem mais difícil no modelo de efetuar Commit de um contêiner.

Caso não tenha o Dockerfile, você pode usar uma imagem à sua escolha como base e então criar a sua imagem como uma camada acima.

## Docker Compose

## Gado vs Animal de Estimação

Pense bem nessa diferença. A sua infraestrutura deve ser composta de componentes que você possa tratar como gado: **auto-suficientes**, **facilmente substituíveis** e **gerenciáveis**.

Isso mesmo, não se apegue aos seus contêineres, eles podem subir, serem replicados, destruídos e gerenciados com uma flexibilidade muito maior.

## Referências

- [Ebook - Docker for the virtualization admin](https://goto.docker.com/rs/929-FJL-178/images/Docker-for-Virtualization-Admin-eBook.pdf)
- [Como Instalar e Utilizar o Docker: Primeiros passos](https://www.digitalocean.com/community/tutorials/como-instalar-e-utilizar-o-docker-primeiros-passos-pt)
- [Docs about Docker](https://docs.docker.com/)
- [Infoslack - Docker](https://infoslack.com/docker/)
- [LinuxTips - Docker Tutorial #1 - Docker, Containers, Images e muito mais!](https://www.youtube.com/watch?v=0cDj7citEjE)

## Conclusão

---
layout: post
title:  "Como replicar banco de dados MySQL"
date: 2015-11-01
image: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiVek5vOursfqsSleIm2QU0lhTjYW3UrubYT2EPkAjxZJmb6kc_Q
categories: [devops]
comments: true
author: leonardorifeli
tags: [featured]
---

Saudações, atuo como desenvolvedor Full-Stack em uma empresa de Araraquara (SP), a wab.com.br. Não sou um expert em servidores e aplicações atuando como tal. Porém gosto de estudar, então pratiquei sobre o assunto a qual os escrevo.

Iremos abordar os seguintes tópicos:

1. Introdução
2. Funcionamento da replicação (teoria)
3. Como iremos replicar (esquema)
4. Replicando um banco de dados MySQL (prática)

## Introdução

A replicação de bancos de dados tem como principal objetivo a **redundância**, onde torna-se uma aplicação mais segura contra falhas e **indisponibilidades de outras aplicações (como o respectivo banco de dados)** e por sua vez um backup online dos dados (em tempo real). Nos tópicos abaixo estaremos abordando todos os processos de replicação.

## Como funciona a replicação?

O **MySQL** possui um recurso de comunicação (onde ocorrerá a replicação) modo **Master-Slave**. Sendo assim, um servidor poderá possuir um banco de dados MySQL rodando como **Master** e **N** bancos de dados atuando como **Slave** (em diferentes servidores).

O servidor atuando em modo **Master** irá gravar todas as alterações efetuadas no banco de dados, em um arquivo de **log binário**. Onde o servidor atuando em modo **Slave** irá requisitar o log binário do **Master** e alterará o próprio arquivo de log binário deixando-o idêntico, onde o MySQL atual aplicando as alterações em si.

Segue abaixo um esquema de replicação **Master-Slave**:

<div style="text-align:center">
	<img class="image" src="/img/posts/2015-11-01-mysql-replication.jpg"/>
	<b>Figura 1.1 - Fonte: Google Images</b>
</div>

## Como iremos replicar (esquema)

Para a replicação do **MySQL**, será utilizado três instâncias **t2.micro** no **Amazon AWS**, conforme abaixo:

<div style="text-align:center">
	<img class="image" src="/img/posts/2015-11-01-amazon-aws.png"/>
	<br/>
	<b>Instâncias - Figura 1.2</b>
</div>

**Observação:** Pode-se analisar na **Figura 1.2** (acima) que as três instâncias encontram-se no mesmo datacenter, porém a replicação também funciona em datacenters diferentes.

Onde os respectivos atuarão em modo:

1. **leonardorifeli-001:** Master
2. **leonardorifeli-002:** Slave
3. **leonardorifeli-003:** Slave

Conforme esquema abaixo:

<div style="text-align:center">
	<img class="image" src="/img/posts/2015-11-01-server-aws-mysql-replication.png"/>
	<br/>
	<b>Figura 1.3</b>
</div>

**PS**: Não entrarei em detalhes sobre o Amazon AWS.

## Replicando um banco de dados MySQL

Vamos ao tão esperado tópico.

As instâncias especificadas na **Figura 1.2** estão rodando com o sistema operacional **Ubuntu Server 14.04 LTS (HVM), SSD Volume Type**, disponibilizado pelo Amazon AWS.

Para a replicação do banco de dados **MySQL** será necessário a instalação da respectiva aplicação (óbvio). Neste post foi utilizado o **mysql-server-5.6**. [Tutorial de instalação](http://sharadchhetri.com/2014/05/07/install-mysql-server-5-6-ubuntu-14-04-lts-trusty-tahr/){:target="_blank"}

Iremos aplicar os seguintes passos:

1. **Servidor Master:** Configurar o servidor Master (arquivo my.cnf)
2. **Servidor Master:** Criar o usuário de replicação e conceder as devidas permissões
3. **Servidores Slaves:** Configurar o servidor (arquivo my.cnf)
4. **Servidores Slaves:** Informar qual será o servidor **Master**

#### 1. Configuração do servidor Master

Após a instalação com sucesso do **MySQL Server 5.6** nas instâncias especificadas na **Figura 1.2**, vamos as respectivas configurações na instância **leonardorifeli-001** que atuará em modo **Master**.

Configurando:

{% highlight bash %}
$ cd /etc/mysql
$ nano my.cnf
{% endhighlight %}

Será necessário editar o arquivo **my.cnf**, ficando da seguinte maneira:

{% highlight text %}
[mysqld]

server-id = 1
log-bin = mysql-bin
bind-address = 0.0.0.0
{% endhighlight %}

Indicamos que o respectivo servidor será o **Master** (pelo server-id). Após editar, executamos o comando abaixo (para reiniciar o servidor MySQL):

{% highlight bash %}
$ service mysql restart
{% endhighlight %}

#### 2. Criar usuário de replicação e conceder as permissões

Agora, iremos criar o usuário para utilizarmos na replicação e conceder para tal as devidas permissões.

Acessando o **MySQL** com usuário root e informando a senha (informado na instalação).

{% highlight bash %}
$ mysql -u root -p
{% endhighlight %}

{% highlight mysql %}
CREATE USER slave IDENTIFIED BY "user-rifeli";

GRANT replication SLAVE, replication CLIENT ON *.* TO slave@'IP-LEONARDORIFELI-002' IDENTIFIED BY 'user-rifeli';

GRANT replication SLAVE, replication CLIENT ON *.* TO slave@'IP-LEONARDORIFELI-003' IDENTIFIED BY 'user-rifeli';

FLUSH PRIVILEGES;
{% endhighlight %}

Criamos o usuário **slave** que responderá pela senha **user-rifeli**.

Enfim, o servidor **Master** encontra-se configurado.

#### 3. Configuração nos servidores que atuarão em modo Slave

O processo de configuração é análogo para ambos servidores, alterando apenas o **server-id** na configuração.

{% highlight bash %}
$ cd /etc/mysql
$ nano my.cnf
{% endhighlight %}

Será necessário editar o arquivo **my.cnf**, da seguinte maneira:

{% highlight text %}
log-bin = mysql-bin
server-id = number-slave
relay-log = mysql-relay-bin
log-slave-updates = 1
{% endhighlight %}

O **server-id** será igual a **2** para a instância **leonardorifeli-002** e igual a **3** para a instância  **leonardorifeli-003**.

Após editar, executamos o comando abaixo (para reiniciar o servidor MySQL):

{% highlight bash %}
$ service mysql restart
{% endhighlight %}

#### 4. Informar para os servidores Slaves qual será o servidor Master

Acessando o MySQL com usuário root e informando a senha (informado na instalação).

{% highlight bash %}
$ mysql -u root -p
{% endhighlight %}

{% highlight mysql %}
CHANGE MASTER TO MASTER_HOST='IP-LEONARDORIFELI-001',
MASTER_USER='slave',
MASTER_PASSWORD='user-rifeli',
MASTER_LOG_FILE='mysql-bin.000001',
MASTER_LOG_POS=0;
{% endhighlight %}

**PS:** Conforme já informado, este processo é análogo para ambos servidores

## Testando a replicação

No servidor **leonardorifeli-001** foi criado o banco **leonardorifeli**, conforme abaixo:

<div style="text-align:center">
	<img class="image" src="/img/posts/2015-11-01-mysql-replication-master.png"/>
	<br/>
	<b>Servidor Master (leonardorifeli-001) - Figura 1.4</b>
</div>

Após esse processo, foi verificado os bancos contidos nos servidores slaves, e foi relatado que a replicação foi um sucesso. Conforme abaixo:

<div style="text-align:center">
	<img class="image" src="/img/posts/2015-11-01-mysql-replication-slave-01.png"/>
	<br/>
	<b>Servidor Slave (leonardorifeli-002) - Figura 1.5</b>
</div>

<div style="text-align:center">
	<img class="image" src="/img/posts/2015-11-01-mysql-replication-slave-02.png"/>
	<br/>
	<b>Servidor Slave (leonardorifeli-003) - Figura 1.6</b>
</div>

## Referências Bibliográficas

Abaixo seguem as referências bibliográficas utilizadas:

1. [Documentação do MySQL](http://dev.mysql.com/doc/refman/5.6/en/replication.html){:target="_blank"}
2. [Configurando acesso remoto ao MySQL](http://www.vivaolinux.com.br/dica/Configurando-acesso-remoto-em-servidores-MySQL){:target="_blank"}

## Conclusão

Recomenda-se o uso da replicação apenas para aplicações robustas que necessitam de redundância ou backup em tempo real e neste caso o servidor **Slave** pode efetuar um backup compactado do banco de dados e enviar para um **Storage no Amazon S3**, por exemplo.

Apenas salientando, a replicação funciona somente de **Master** para **Slave** (conforme **Figura 1.1 e 1.3**) e não o contrário.

## Informações Adicionais

Este artigo surgiu para aplicação e documentação dos assuntos abordados e como sempre, transferência de conhecimentos.

Espero que as informações supramencionadas sejam úteis.

Façam seus comentários no espaço abaixo e compartilhe este post.

Abraços e até o próximo post.

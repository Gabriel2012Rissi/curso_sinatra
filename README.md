# Curso Sinatra
API RESTful com Sinatra para Workshop Claretiano Nov/2017

## Como usar?

Este repositório foi construído na ordem Pull Requests enviados. Você pode observar o que cada pull request modificou, dentro do github.

#### Instalando

1. Para usar o [Vagrant](https://www.vagrantup.com) é necessário primeiramente efetuar a instalação da ferramenta.

```console
$ wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
$ echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
$ sudo apt update && sudo apt install vagrant
```

2. Para criar a máquina virtual, use o comando:

```console
$ vagrant up
```

3. Para provisionar a máquina virtual, após eventuais alterações, use o comando:

```console
$ vagrant provision
```

4. Para acessar a sua máquina virtual via SSH, use:

```console
$ vagrant ssh
```

#### Executando

Para facilitar, algumas tarefas já foram automatizadas:

```console
$ make install_dependencies
$ make build
```

Para criar a base e rodar as migrations

```console
$ make setup
```

Rode o servidor

```console
$ make up
```

E acesse a página http://localhost:3000/ no seu navegador

Se quiser acessar o console

```console
$ make console
```

HINT: Certifique-se de dar um `chmod +x sinatra/bin/console` para que ele seja executável.
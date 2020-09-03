# My Vim Config

Este repositório contém todas as configurações que eu utilizo no meu Vim.

OBS: Todas as configurações encontradas neste repositório foram feitas
utiliando o [Neovim](https://github.com/neovim/neovim), não há garantia que
tudo vá funcionar igualmente no Vim padrão.

OBS2: Para abrir o Neovim a partir dos comandos 'vi' ou 'vim' no lugar de
'nvim' basta adicionar um alias no seu arquivo .bashrc ou criar um arquivo
.bash_aliases no seu home folder e adicionar as seguinte linhas:

```shell
alias vim=nvim
alias vi=nvim
```

## Instalando os plugins

Coloque o arquivo '.vimrc' no seu home folder.

Abra-o utilizando o vim:

```bash
vim .vimrc
```

Instale os plugins inserindo o comando:

```vim
:PlugInstall
```

Após esse comando uma janela irá aparecer e o vim instalará todos os plugins
definidos no arquivo .vimrc

## Corretor ortográfico

O vim também possui um corretor ortográfico, para ativar ele basta inserir o
seguinte comando quando estiver editando um arquivo:

```vim
:setlocal spell spelllang=*idioma*
```

O *idioma* é o idioma a ser utilizado, por exemplo:

* en
* pt

Caso o arquivo de dicionário ainda não exista no seu computador, o vim irá
baixá-lo para você.

## Fonte Utilizada

Nesta configuração, a fonte utilizada é a RobotoMono Nerd Font Mono Medium.
Esta fonte e muitas outras, inclusive as que contém os ícones utilizados no
airline, podem ser [instaladas a partir deste
repositório](https://github.com/ryanoasis/nerd-fonts).

Para instalar as fontes basta inserir os seguintes comandos no terminal:

```shell
git clone https://github.com/ryanoasis/nerd-fonts --depth=1
cd nerd-fonts
./install.sh
```

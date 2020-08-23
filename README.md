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

## Auto Completer - [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe)

Para que o auto completer funcione é preciso compilá-lo, mais informações sobre
isso [aqui](https://github.com/ycm-core/YouCompleteMe).

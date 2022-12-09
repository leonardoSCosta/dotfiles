# Criar acesso via SSH Github/Gitlab

O primeiro passo é gerar a chave SSH, o email deve ser o da conta
(Github/Gitlab).

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Após isso deve ser fornecido o local onde as chaves serão salvas e uma senha.

Para adicionar a chave ao cliente SSH basta utilizar o seguinte comando.

```shell
ssh-add <caminho para a chave privada>
```

Então, basta adicionar a chave pública à conta do Github/Gitlab.


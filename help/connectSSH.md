# Criar acesso via SSH Github/Gitlab

O primeiro passo é gerar a chave SSH, o email deve ser o da conta
(Github/Gitlab).

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Após isso deve ser fornecido o local onde as chaves serão salvas e uma senha.

```shell
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/leonardo/.ssh/id_ed25519): 
# Aqui, caso desejado, deverá ser colocado o caminho absoluto. Exemplo:
/home/leonardo/.ssh/chave_teste
```
Então, ele vai pedir a senha, não precisa colocar, só aperte *Enter* em tudo.

Deve aparecer isso aqui

`
Your identification has been saved in /home/leonardo/.ssh/chave_teste
Your public key has been saved in /home/leonardo/.ssh/chave_teste.pub
The key fingerprint is:
SHA256:jj4yKjQGlWecVzk7luhbdgRB0uL4X47yxHIRz9uYTPA Teste
The key's randomart image is:
+--[ED25519 256]--+
|   o ..++o       |
|  o = o.=        |
| . o + oo=       |
|.   . o =*.      |
|.    o .SoE      |
| +    o+o+o=     |
|o .   o==== .    |
|.   o.++o .      |
| ... o.+.        |
+----[SHA256]-----+
` 

Para adicionar a chave ao cliente SSH basta utilizar o seguinte comando.

```shell
# ssh-add <caminho para a chave privada>: Exemplo
ssh-add /home/leonardo/.ssh/chave_teste
```

Então, basta adicionar a chave pública (arquivo
`/home/leonardo/.ssh/chave_teste.pub`) à conta do Github/Gitlab.


# Conexão SSH entre máquinas

- Gerar chave SSH na máquina fonte

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

- Copiar chave SSH (.pub) para a máquina destino:

```shell
ssh-copy-id -i <nome_da_chave> user@<ip>
```

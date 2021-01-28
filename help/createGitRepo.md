# Como criar um repositório do git a partir de uma pasta local

Vá para dentro da pasta e então:

```shell
git init
touch .gitignore
git add --all
git commit -m "Initial commit"
git remote add origin git@gitlab.com:leo_costa/<nome do projeto>
git push -u origin master
```

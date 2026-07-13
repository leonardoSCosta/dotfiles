```bash
git fetch origin

git rebase origin/main
```

Resulta em histórico:

```git
main
 ──A1──A2──A3────────────
                 \
                  B1──B2
```

Após rebase as branchs irão divergir, isso é normal.

Para subir as mudanças utilize:

```bash
git push --force-with-lease origin feat-recovery-refactor
```

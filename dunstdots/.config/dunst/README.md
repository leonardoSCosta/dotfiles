# Dunst

Para usar o *dunst* no lugar do serviço padrão do gnome é necessário mudar o
arquivo `/usr/share/dbus-1/services/org.gnome.Shell.Notifications.service` da
seguinte forma:

```shell
[D-BUS Service]
Name=org.gnome.Shell.Notifications
/*Exec=/usr/bin/gjs /usr/share/gnome-shell/org.gnome.Shell.Notifications*/
Exec=/usr/local/bin/dunstify
```

Para testar use o comando:

```shell
systemctl restart --user dunst.service; notify-send foo bar; notify-send zoo foo
```

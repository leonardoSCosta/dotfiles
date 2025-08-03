# How to install updated TeXLive on Ubuntu

```shell
cd /tmp
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-*
sudo perl ./install-tl --no-interaction
```

Add TeXLive binaries to path:

```shell
export PATH=/usr/local/texlive/2024/bin/your-architecture:$PATH
```

The correct path can be seen on the end on the installation.

Check:

```shell
latex --version
```

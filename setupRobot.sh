sudo apt install -y git kitty fish zoxide meld fd-find ripgrep ninja-build gettext cmake unzip curl build-essential
cd ~/Downloads/
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

# Fisher
fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install edc/bass

starship init fish | source
export "BAT_THEME=Dracula"
export "EDITOR=nvim"

alias grsim=~/SSL/grSim/bin/grSim
alias tempo=~/.weather
alias cleanJournal=~/.cleanJournal
alias refbox=~/.refbox
alias vim=nvim
alias vi=nvim
alias python=python3
alias connectLARC=~/connectLARC
alias connectRoot=~/connectRoot
alias gamecontroller=~/SSL/ssl-game-controller_v2.0.0-rc3_linux_amd64
alias stmide=~/st/stm32cubeide_1.5.0/stm32cubeide
alias stmmx=~/STM32CubeMX/STM32CubeMX
alias pip=pip3
alias matlab=~/MATLAB/R2020b/bin/matlab
alias fd=fdfind
alias icat="kitty +kitten icat --align left"
alias get_lx106='export PATH="$PATH:$HOME/esp/xtensa-lx106-elf/bin"'
alias list_terminals='sudo update-alternatives --config x-terminal-emulator'
alias clock="tty-clock -s -c -C5 -r"
alias toggle_notifs="dunstctl set-paused toggle; echo 'Notifications paused ?'; dunstctl is-paused"
alias lg='git status'
alias update='sudo apt-get -y update; sudo apt-get -y upgrade; sudo apt autoremove -y'

function move_date
    mkdir Dia_$argv; la | rg $argv | awk '{print $7}'| xargs -I '{}' mv {}  Dia_$argv/
end

function compile_C
    gcc $argv.c -o $argv; ./$argv
end

function compile_adoc
    asciidoctor-pdf $argv.adoc; asciidoctor $argv.adoc ; zathura $argv.pdf &
end

function ls
    exa --group-directories-first --icons -h -m --git --time-style long-iso $argv
end

function lst
    ls -T -L $argv
end

function clc
    clear
end

function shut_reason
    cat /var/log/kern.log | rg shutting
end

function readSerial
    ~/Tools/./serialReaderCLI --log-dir ~/SGRIDD/seriallogs/ $argv
end

function cheat
    if count $argv > /dev/null
        curl cht.sh/$argv
    else
        echo "Insira {lang}/{command}"
    end
end

function fish_greeting
    colorscript -r
end

function bit
    coinmon -f btc
end

function ..
    cd ..
end

function GitCommit
    if count $argv > /dev/null
        git add --all; git commit -m $argv; git push
    else
        echo "Insira a mensagem de commit!"
    end
end

function track_enable
    xinput set-prop 16 "Device Enabled" $argv
end

function compressPDF
    if count $argv > /dev/null
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
        -dNOPAUSE -dQUIET -dBATCH -sOutputFile=Output.pdf $argv
    else
        echo "Insira o arquivo para ser comprimido!"
    end
end

function count_lines
    fd -s -F \.cpp | xargs -I '{}' wc -l {} | awk '{print $1}' > aux
    fd -s -F \.h | xargs -I '{}' wc -l {} | awk '{print $1}' >> aux
    cat aux | xargs  | sed -e 's/\ /+/g' | bc
    rm aux
end

function count_py_lines
    fd -s -F \.py | xargs -I '{}' wc -l {} | awk '{print $1}' > aux
    cat aux | xargs  | sed -e 's/\ /+/g' | bc
    rm aux
end

function sound
    # int
    pactl set-default-sink $argv
end

function set_tiling
    # true/false
    gsettings set org.gnome.shell.overrides edge-tiling $argv
end

function clean_latex
    rm -f *.xmpi
    rm -f *.aux
    rm -f *.bbl
    rm -f *.bcf
    rm -f *.blg
    rm -f *.idx
    rm -f *.lof
    rm -f *.log
    rm -f *.lot
    rm -f *.mw
    rm -f *.out
    rm -f *.run.xml
    rm -f *.synctex.gz
    rm -f *.toc
    rm -f *.xdy
    rm -f *.alg
    rm -f *.fdb_latexmk
    rm -f *.fls
    rm -f *.ilg
    rm -f *.ind

    rm -f ./pre-textuais/*.aux
    rm -f ./textuais/*.aux
end

function setup_webots
    export WEBOTS_HOME=/usr/local/webots
    compiledb make
end

function prepend_n
    mv $argv[1] $argv[2]_$argv[1]
end

abbr -a -g cvim vim ~/.vimrc

starship init fish | source

alias grsim=~/.grsim
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

function ls
    exa --group-directories-first --icons -l -h -m --git --time-style long-iso $argv
end

function readSerial
    ~/Tools/./serialReaderCLI --port-name ttyUSB0 --port-baud 115200 --log-dir ~/SGRIDD/seriallogs/ $argv
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

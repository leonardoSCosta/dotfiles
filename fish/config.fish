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

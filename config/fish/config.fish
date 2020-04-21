# Fisher install
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Aliases
alias l='ls -lhvX --color=auto --group-directories-first'
alias la='ls -lahvX --color=auto --group-directories-first'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Auto ls when cd
function cd
    if count $argv > /dev/null
        builtin cd "$argv"; and l
    else
        builtin cd ~; and l
    end
end

# Prompt
function fish_prompt
    # Clear existing line content
    echo -e -n "\r\033[K\n"

    set_color blue
    echo -e -n '❯' (set_color normal)
end

function rgr
    rg -0 -l "$argv[1]" | xargs -0 perl -pi.bak -e "s/$argv[1]/$argv[2]/g";
end

function rgd
    rg -0 -l "$argv[1]" | xargs -0 sed -i "'$argv[1]'d";
end

# Golang
set -x GOPATH /home/adam/go
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin /snap/bin

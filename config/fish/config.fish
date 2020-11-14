# Aliases
alias l='ls -lhvX --color=auto --group-directories-first'
alias la='ls -lahvX --color=auto --group-directories-first'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

alias j=z

function toggle_theme
  set file ~/.config/alacritty/alacritty.yml
  set batfile ~/.config/bat/config
  if rg -q "\*light" $file
    sed -i 's/*light/*dark/g' $file
    sed -i 's/light/dark/g' $batfile
  else
    sed -i 's/*dark/*light/g' $file
    sed -i 's/dark/light/g' $batfile
  end
end

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
set -x GOPATH $HOME/go
set -x PATH /usr/local/opt/gnu-sed/libexec/gnubin /usr/local/opt/coreutils/libexec/gnubin $PATH /usr/local/go/bin $GOPATH/bin /snap/bin

set fish_color_command green
set fish_color_error red
set fish_color_param blue
set fish_color_operator blue
set fish_greeting "Welcome back Adam"

set -U FZF_LEGACY_KEYBINDINGS 0
set -U EDITOR nvim
set -U FZF_DEFAULT_OPTS "--ansi --height 50% --color dark --color fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef"
set -U FZF_FIND_FILE_COMMAND "fd --color=always --hidden --exclude .git --type f . \$dir"
set -U FZF_OPEN_COMMAND "fd --color=always --hidden --exclude .git --type f . \$dir"
set -U FZF_PREVIEW_FILE_CMD "bat --color=always --style=numbers,grid --line-range :300"
set -U FZF_ENABLE_OPEN_PREVIEW 1

# Kubectl aliases
# This command is used a LOT both below and in daily life
alias k=kubectl

# Apply a YML file
alias kaf='kubectl apply -f'

# Drop into an interactive terminal on a container
alias keti='kubectl exec -ti'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'

# List all contexts
alias kcgc='kubectl config get-contexts'

# General aliases
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'

# Pod management.
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kep='kubectl edit pods'
alias kdp='kubectl describe pods'
alias kdelp='kubectl delete pods'

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kgp -l'

# Service management.
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc --all-namespaces'
alias kgsw='kgs --watch'
alias kgswide='kgs -o wide'
alias kes='kubectl edit svc'
alias kds='kubectl describe svc'
alias kdels='kubectl delete svc'

# Ingress management
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias kdelns='kubectl delete namespace'
alias kcn='kubectl config set-context (kubectl config current-context) --namespace'

# ConfigMap management
alias kgcm='kubectl get configmaps'
alias kgcma='kubectl get configmaps --all-namespaces'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'

# Secret management
alias kgsec='kubectl get secret'
alias kgseca='kubectl get secret --all-namespaces'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Deployment management.
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgdw='kgd --watch'
alias kgdwide='kgd -o wide'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'

# Rollout management.
alias kgrs='kubectl get rs'
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'

# Statefulset management.
alias kgss='kubectl get statefulset'
alias kgssa='kubectl get statefulset --all-namespaces'
alias kgssw='kgss --watch'
alias kgsswide='kgss -o wide'
alias kess='kubectl edit statefulset'
alias kdss='kubectl describe statefulset'
alias kdelss='kubectl delete statefulset'
alias ksss='kubectl scale statefulset'
alias krsss='kubectl rollout status statefulset'

# Port forwarding
alias kpf="kubectl port-forward"

# Tools for accessing all information
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'

# Logs
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'

# File copy
alias kcp='kubectl cp'

# Node Management
alias kgno='kubectl get nodes'
alias keno='kubectl edit node'
alias kdno='kubectl describe node'
alias kdelno='kubectl delete node'

# PVC management.
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'
alias kgpvcw='kgpvc --watch'
alias kepvc='kubectl edit pvc'
alias kdpvc='kubectl describe pvc'
alias kdelpvc='kubectl delete pvc'

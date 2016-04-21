[ -f "$HOME/.aliases" ] && source $HOME/.aliases

export NVM_DIR="/Users/yichizhang/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm



[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$HOME/.functions" ] && source "$HOME/.functions"

# Add env.sh
. ~/Projects/config/env.sh
. ~/__scripts/z/z.sh


. ~/.aliases

[ -f "$HOME/.aliases" ] && source $HOME/.aliases

export NVM_DIR="/Users/yichizhang/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm



[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$HOME/.functions" ] && source "$HOME/.functions"
[ -f "$HOME/.functions_private" ] && source "$HOME/.functions_private"
[ -f "$HOME/.functions_git" ] && source "$HOME/.functions_git"

# Add env.sh
. ~/Projects/config/env.sh
. ~/__scripts/z/z.sh


. ~/.aliases

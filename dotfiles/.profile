[ -f "$HOME/.profile.private" ] && source $HOME/.profile.private

[ -f "$HOME/.aliases" ] && source $HOME/.aliases

export NVM_DIR="/Users/yichizhang/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -d "/Library/Developer/CommandLineTools" ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

export EDITOR=vim
#export PROJ_ROOT=$HOME
#export PROJ_ROOT=/Volumes/a3f20b7e/xdev
export PROJ_ROOT=/Volumes/a3f20b7e

# PATH
export PATH="$PATH:/usr/local/heroku/bin"
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH=".git/safe/../../bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export ANDROID_HOME=/usr/local/opt/android-sdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

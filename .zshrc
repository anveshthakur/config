# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=~/go/bin:$PATH
export JAVA_HOME="$SDKMAN_CANDIDATES_DIR/java/current"
export PATH="$JAVA_HOME/bin:$PATH"
export CLOUDSDK_PYTHON=/Users/nineleaps/.pyenv/shims/python3
export EDITOR=vim

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z zsh-autosuggestions golang you-should-use zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshconfig="nvim ~/.zshrc"
alias wezconfig="nvim ~/.config/wezterm/wezterm.lua"
alias nvimconfig="cd ~/.config/nvim && nvim ."
alias c="clear"
alias x="exit"
alias nvimd="nvim ."
alias lg="lazygit"
alias ld="lazydocker"
alias vim="nvim"
alias nstop="sudo launchctl unload /Library/LaunchDaemons/com.netskope.client.auxsvc.plist"
alias nstart="sudo launchctl load /Library/LaunchDaemons/com.netskope.client.auxsvc.plist"
alias nifilogs="vim ~/nifi-2.4.0/logs/nifi-app.log"
alias oc="opencode"

# starship
eval "$(starship init zsh)"

export GPG_TTY=$(tty)

export GOPATH=$HOME/go
export GOPRIVATE="github.com/headlamp-health"
export GO_MODULES_TOKEN=
export AIRFLOW_HOME="/Users/nineleaps/airflow"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


function db_port() {
    if [ $# -ne 1 ]; then
        echo "Usage: db_port <new_port>"
        return 1
    fi

    local port=$1
    local config_file="$HOME/Library/DBeaverData/workspace6/General/.dbeaver/data-sources.json"
    local config_file_updated="$HOME/Library/DBeaverData/workspace6/General/.dbeaver/data-sources_updated.json"
    local script_path="$HOME/scripts/dbeaver-ports.py" 

    if [ ! -f "$config_file" ]; then
        echo "Error: Config file not found at $config_file"
        return 1
    fi

    if [ ! -f "$script_path" ]; then
        echo "Error: Script file not found at $script_path"
        return 1
    fi

    # Run the Python script to update the port
    python3 "$script_path" --file "$config_file" --port "$port"

    # Check if the updated file exists before moving
    if [ ! -f "$config_file_updated" ]; then
        echo "Error: Failed to create the updated config file."
        return 1
    fi

    # Move the updated file back to the original location
    mv "$config_file_updated" "$config_file"
    echo "Config file updated successfully."

    # Optionally, clean up any residual files (though this should already be done by mv)
    # rm "$config_file_updated"
}
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

stage() {
    cd ~/ssm-forward/
    ./port-forward.sh stage
}

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nineleaps/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nineleaps/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nineleaps/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nineleaps/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# opencode
export PATH=/Users/nineleaps/.opencode/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH=$JAVA_HOME/bin:$PATH

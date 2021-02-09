# Configuring Our Prompt
# ======================
  # This function is called in your prompt to output your active git branch.
  function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  # This function builds your prompt. It is called below
  function prompt {
    # Define the prompt character
    local   CHAR="〈( •ㅅ•)ノ" ## ♥ ☆ ♬ ○ ♩ ● ♪ ➢ - Keeping some cool ASCII Characters for reference
    local   EMOJI="🥀"
    local   ARROW="➢ "
    local   B_C="⟫"
    local   B_S="⟪"
    # Define some local colors
    local   RED="\[\e[0;31m\]"
    local   BLUE="\[\e[0;34m\]"
    local   GREEN="\[\e[0;32m\]"
    local   YELLOW="\[\e[0;33m\]"
    local   PURPLE="\[\e[0;35m\]"
    local   CYAN="\[\e[0;36m\]"
    local   WHITE="\[\e[0;37m\]"
    local   GRAY_TEXT_BLUE_BACKGROUND="\[\e[37;44;1m\]"
    # Define a variable to reset the text color
    local   RESET="\[\e[0m\]"
    # ♥ ☆ - Keeping some cool ASCII Characters for reference
    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\n\[\e]2;\u@\h\a$GREEN$B_S \@ $B_C$RESET$PURPLE\$(parse_git_branch) $CYAN\W\n $BLUE$CHAR $ARROW $RESET"
      PS2="$ARROW "
      PS4='+ '
    }
  # Finally call the function and our prompt is all pretty
  prompt

# Environment Variables
# ======================
  # Configurations
    # GIT_MERGE_AUTO_EDIT
    # This variable configures git to not require a message when you merge.
    export GIT_MERGE_AUTOEDIT='no'
    # Editors
    # Tells your shell that when a program requires various editors, use sublime.
    # The -w flag tells your shell to wait until sublime exits
    export VISUAL="code"
    export SVN_EDITOR="code"
    export GIT_EDITOR="code"
    export EDITOR="code"

# Helpful Functions
# ======================
  # A handy function to open your bash profile from any directory
  function bp {
    $EDITOR ~/.bash_profile
  }
  # Helper funtion that creates a table
  helptable () {
    # USAGE: helptable "COMMAND" "DESCRIPTION" items[@] descriptions[@]
    local item=$1
    local descriptor=$2
    local items=("${!3}")
    local descriptions=("${!4}")
    local CYAN="\e[0;36m"
    local RESET="\e[0m"
    local BLUE="\e[0;34m"
    local GREEN="\e[0;32m"
    COLORED=true
    header="  $GREEN%-25s %s \n"
    divider="$RESET  ◇──◇──◇───────────────────◇──◇───◇─────────────────────────────◇──◇──◇"
    local format="\n\n  %-25s %-40s"
    printf "\n$divider\n\n"
    printf  "$header" "$1" "$2"
    printf "$divider"

    for ((i=0;i<${#items[@]};++i)) do
      if [ "$COLORED" == "true" ] ; then
        printf "$RESET"
        COLORED=false
      else
        printf "$CYAN"
        COLORED=true
      fi
      printf "$format" "${items[i]}" "${descriptions[i]}"
    done

    printf "\n\n$divider\n"

  }

  # Function that lists useful functions and aliases
  function helpme {
    # USAGE: helpme
    local items=(
      "helpme" 
      "pwd"
      "home"
      "ls" 
      "cd .." 
      "mkdir" 
      "touch" 
      "code ." 
      "gcl"
      "ga"
      "gcam"
      "gp"
      "gpush"
      "gs"
      "gl"
      "gba"
      "gc"
      "gcb"
    ) 
    local descriptions=(
      "literally this table right here" 
      "shows parent working directory"
      "goes to root directory"
      "lists files in current directory" 
      "goes to the parent directory" 
      "new folder in current directory"
      "new file in current directory"
      "opens current directory in vsCode"
      "⟪ clones repo, cd's to generated folder ⟫"
      "git add . ⟪ stages changes for commit ⟫"
      "git commit -am ⟪ commits with message ⟫"
      "git pull"
      "git push && gs"
      "git status"
      "⟪ pretty git log ⟫"
      "git branch --all ⟪ lists git branches ⟫"
      "git checkout ⟪ switches to branch ⟫"
      "git checkout -b ⟪ creates new branch ⟫"
    )
    helptable "COMMAND" "DESCRIPTION" items[@] descriptions[@]
  }
  # called in every loading of this file
  helpbb

  # Used as a replacement of git clone
  function gcl () {
    IFS="/"
    read -ra ADDR <<< "$1"
    IFS="."
    read -ra FILENAME <<< "${ADDR[1]}"
    git clone "$1" && cd "${FILENAME[0]}"
    printf "\n \e[0;32m Successfuly cloned repo ${FILENAME[0]}\n\e[0m"
    printf "\nYou are now in: \e[0;33m $(pwd)\n"
    printf "\n \e[0;36m Have fun coding! \e[0m\n"
  }

  # Used as a replacement of git status
  function gs () {
    printf "============================="
    git status
    printf "============================="
  }

  # Used as a replacement of rm -rf
  function remove () {
    sudo rm -rf "$1"
    printf "\n Deleted folder \e[0;31m$1 \n\e[0m\n"
    printf "============================="
    ls
  }

  # Just so you don't have to install all the gems in succession
  function initialgems () {
    gem install bundler
    gem install nokogiri
    gem install pry
    gem install rspec
    gem install rails
    gem install rake
    gem install git
    gem install jasmine
    gem install netrc
    gem install oj
    gem install crack
    gem install faraday
  }

# Aliases
# ======================
  alias ls="ls -aF1"
  alias gp="git pull"
  alias gpr="git pull --rebase"
  alias gpush="git push && gs"
  alias ga="git add . && gs"
  alias gcam="git commit -am"
  alias grao="git remote add origin"
  alias gba="git branch --all"
  alias gsearch="git branch --all | grep"
  alias gl="git log --pretty=format:\"%n%Cblue%h%Creset%C(red)%d%Creset%n%C(cyan)%s%Creset%n%an, %ar\""
  alias gr="git reset"
  alias gc="git checkout"
  alias gcb="git checkout -b"
  alias gdlocal="git branch -D"
  alias setbp="source ~/.bash_profile"
  alias home="cd ~"


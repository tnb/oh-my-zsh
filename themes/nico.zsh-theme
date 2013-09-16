function my_git_prompt() {
  tester=$(git rev-parse --git-dir 2> /dev/null) || return

  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""

  # is branch ahead?
  if $(echo "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi

  # is anything staged?
  if $(echo "$INDEX" | grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi

  # is anything unstaged?
  if $(echo "$INDEX" | grep -E -e '^[ MARC][MD] ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi

  # is anything untracked?
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  # is anything unmerged?
  if $(echo "$INDEX" | grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  if [[ -n $STATUS ]]; then
    STATUS="$STATUS"
  fi

  if $(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref HEAD) &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_TRAKING_PREFIX$(my_tracking_branch)$ZSH_THEME_GIT_PROMPT_TRAKING_SUFFIX$STATUS"
  fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch)$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_current_branch() {
  echo $(current_branch || echo "(no branch)")
}

function my_tracking_branch(){
  echo `git for-each-ref --format='%(upstream:short)' $(git symbolic-ref HEAD)`
}


PROMPT='%{$fg_bold[green]%}%n@%m $(my_git_prompt)%{$fg[blue]%}%~%{$fg[red]%} » %{$reset_color%}'



ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}‹%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[magenta]%}▴"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}•"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}•"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}•"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}⁎"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}› "
ZSH_THEME_GIT_PROMPT_TRAKING_PREFIX="%{$FG[005]%}(▸"
ZSH_THEME_GIT_PROMPT_TRAKING_SUFFIX=")"

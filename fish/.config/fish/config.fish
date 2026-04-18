abbr -a v nvim
abbr -a c cargo
abbr -a m make
abbr -a k kubectl

abbr -a g git
abbr -a gst 'git status'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a glo 'git log --oneline'
abbr -a glp 'git log -p'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a ga 'git add -p'
abbr -a gaa 'git add -A'
abbr -a gc 'git commit -v'
abbr -a gc! 'git commit -v --amend'
abbr -a gl 'git pull'
abbr -a gp 'git push'
abbr -a gwa 'git worktree add'
abbr -a gwr 'git worktree remove'

alias vim="nvim"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx RUST_BACKTRACE 1

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

function fish_prompt
    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    set_color blue
    echo -n $USER

    if [ $PWD != $HOME ]
      set_color brblack
      echo -n ':'
      set_color yellow
      echo -n (basename $PWD)
	  end

	  set_color green
	  printf '%s ' (__fish_git_prompt)
	  set_color red
	  echo -n '| '
	  set_color normal
end


set PATH ~/.local/bin \
   ~/.cargo/bin $PATH


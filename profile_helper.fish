#!/usr/bin/env fish

# [what] provides aliases for base16 themes and sets ~/.base16_theme
#
# [usage] can be added to ~/.config/fish/config.fish like so:
#
# if status --is-interactive
#    source $HOME/.config/base16-shell/profile_helper.fish
# end
#
# TODO: maybe port to $HOME/.config/fish/functions ?

 set SCRIPT_DIR (realpath (dirname (status -f)))
# set -gx SCRIPT_DIR ./scripts

# load currently active theme...
if test -e ~/.base16_theme
<<<<<<< HEAD
  sh $XDG_CONFIG_HOME/base16-shell/realpath/realpath.sh ~/.base16_theme
||||||| merged common ancestors
  sh (realpath ~/.base16_theme)
=======
  set -l SCRIPT_NAME (basename (realpath ~/.base16_theme) .sh)
  set -gx BASE16_THEME (string match 'base16-*' $BASE16_THEME  | string sub -s (string length 'base16-*'))
  eval sh '"'(realpath ~/.base16_theme)'"'
>>>>>>> ce8e1e540367ea83cc3e01eec7b2a11783b3f9e1
end


# set aliases, like base16_*...
for SCRIPT in $SCRIPT_DIR/scripts/*.sh
  set THEME (basename $SCRIPT .sh)
  function $THEME -V SCRIPT -V THEME
    sh $SCRIPT
    ln -sf $SCRIPT ~/.base16_theme
    set -gx BASE16_THEME (string split -m 1 '-' $THEME)[2]
    echo -e "if !exists('g:colors_name') || g:colors_name != '$THEME'\n  colorscheme $THEME\nendif" >  ~/.vimrc_background
    if test (count $BASE16_SHELL_HOOKS) -eq 1; and test -d "$BASE16_SHELL_HOOKS"
      for hook in $BASE16_SHELL_HOOKS/*
        test -f "$hook"; and test -x "$hook"; and "$hook"
      end
    end
  end
end

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%} on %{%B$FG[003]%}\xee\x82\xa0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%B$FG[003]%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$reset_color%}%{$fg_bold[001]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%B$FG[004]%}%n %{$fg_bold[white]%}at %{%B$FG[006]%}%m %{%B$FG[white]%}in %{%B$FG[002]%}%3c%{$reset_color%}$(git_prompt_info)
%{$fg_bold[white]%}› %{$reset_color%}'

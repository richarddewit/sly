# -*- mode: sh; -*- vim: set ft=sh:
#
### Bash autocompletion for sly
### https://github.com/richarddewit/sly

_sly()
{
  local current_word
  COMPREPLY=()
  current_word="${COMP_WORDS[COMP_CWORD]}"
  # shellcheck disable=SC2207
  COMPREPLY=($(compgen -W "$(sly -a)" -- "${current_word}"))

  return 0
}
complete -F _sly sly

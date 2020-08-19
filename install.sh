#!/usr/bin/env bash

curl_cmd="sudo curl -sL https://raw.githubusercontent.com/richarddewit/sly/master/sly -o /usr/local/bin/sly"
chmod_cmd="sudo chmod +x /usr/local/bin/sly"
echo "$curl_cmd && $chmod_cmd"
$curl_cmd && $chmod_cmd

echo
echo

ac_loc="/etc/bash_completion.d/sly-completion.bash"
ac=y
read -r -n 1 -p "Do you want autocompletion? [Yn]" ac
if [[ $ac =~ ^(y|Y|)$ ]]; then
  curl_cmd="sudo curl -sL https://raw.githubusercontent.com/richarddewit/sly/master/sly-completion.bash -o $ac_loc"
  echo "$curl_cmd"
  $curl_cmd

  echo
  echo
  echo "Completion file created at $ac_loc"
  echo "Make sure you have bash_completion installed and sourced."

  if [ -f "$HOME/.zshrc" ]; then
    source_cmd="source /etc/bash_completion.d/sly-completion.bash"
    if grep -q "$source_cmd" "$HOME/.zshrc"; then
      echo "Line '$source_cmd' already in .zshrc"
    else
      echo "$source_cmd" >> "$HOME/.zshrc"
      echo "Line added to ~/.zshrc:   $source_cmd"
      echo "Make sure to load 'compinit' in your .zshrc before this source line."
    fi
  fi

fi

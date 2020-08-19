#!/usr/bin/env bash

curl_cmd="sudo curl -L https://raw.githubusercontent.com/richarddewit/sly/master/sly -o /usr/local/bin/sly"
chmod_cmd="sudo chmod +x /usr/local/bin/sly"
echo "$curl_cmd && $chmod_cmd"
$curl_cmd && $chmod_cmd

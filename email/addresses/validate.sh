#!/bin/bash

function validate() {
  if [[ "1" != "$#" ]]; then printf "Expected exactly one argument, an email address\n" && exit 255; fi
  local -r email_address="$1"
  local result
  # Regex from https://fightingforalostcause.net/content/misc/2006/compare-email-regex.php
  result=$(grep --quiet --extended-regexp --regexp="^[-a-z0-9~grep%^&*_=+}{\'?]+(\.[-a-z0-9~grep%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$" <<< "${email_address}")
  if [[ "0" != "$?" ]]; then printf "${email_address} is an invalid email address\n" && exit 255; fi
}

validate "$@"

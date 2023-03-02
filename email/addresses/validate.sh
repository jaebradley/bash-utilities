#!/bin/bash

function validate() {
  if [[ "1" != "$#" ]]; then printf "Expected exactly one argument, an email address\n" && exit 255; fi
  local -r email_address="$1"

  type grep > /dev/null 2>&1
  if [[ $? -ne 0 ]]; then printf "Unable to identify the grep command\n" && exit 255; fi

  # Regex from https://fightingforalostcause.net/content/misc/2006/compare-email-regex.php
  grep --quiet --extended-regexp --regexp="^[-a-z0-9~grep%^&*_=+}{\'?]+(\.[-a-z0-9~grep%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$" <<< "${email_address}"
  if [[ $? -ne 0 ]]; then printf "Unable to validate email address: ${email_address}\n" && exit 255; fi
}

validate "$@"

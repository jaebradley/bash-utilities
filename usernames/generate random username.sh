#!/bin/bash

main() {
  if [[ "1" != "$#" ]];
  then
    printf "Expected a single argument: the length of the username\n" && exit 255
  fi

  local -r username_length="$1"
  local iterations
  iterations=$(($username_length / 32))
  if [[ "0" != "$?" ]]; then printf "Unable to calculate iterations\n" && exit 255; fi

  local username=""
  local hashed_username_component=""
  for iteration in $(seq 0 "${iterations}")
  do
    hashed_username_component=$(uuidgen | md5)
    if [[ "0" != "$?" ]]; then printf "Unable to calculate hashed username component\n" && exist 255; fi
    username+="${hashed_username_component}"
  done

  head -c "${username_length}" <<< "${username}"
}

main "$@"

#!/bin/bash

main() {
  if [[ "8" != "$#" ]];
  then
    printf "Expected eight arguments: email address, name of captain, start date (MM-DD-YYYY), start time (H:MM), outcome, opposing team color, runs scored, opposing runs scored\n" && exit 255
  fi

  local -r email_address="$1"
  # TODO: validate email address
  local -r name_of_captain="$2"
  # TODO: validate captain's name is not blank
  local -r start_date="$3"
  # TODO: validate start date is formatted properly
  local -r start_time="$4"
  # TODO: validate start time is formatted properly
  local -r outcome="$5"
  # TODO: must be "Won", "Lost" or "Tied"
  local -r opposing_team_color="$6"
  # TODO: must not be empty string
  local -r runs_scored="$7"
  # TODO: must be an integer
  local -r opposing_runs_scored="$8"
  # TODO: must be an integer
  

  curl 'https://bssc.com/cbFormBuilder/formRender/submitForm' -X POST \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0) Gecko/20100101 Firefox/102.0' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' \
    -H 'Accept-Language: en-US,en;q=0.5' \
    -H 'Accept-Encoding: gzip, deflate, br' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H 'Origin: https://bssc.com' \
    -H 'Connection: keep-alive' \
    -H 'Referer: https://bssc.com/report-scores' \
    -H 'Upgrade-Insecure-Requests: 1' \
    -H 'Sec-Fetch-Dest: document' \
    -H 'Sec-Fetch-Mode: navigate' \
    -H 'Sec-Fetch-Site: same-origin' \
    -H 'Sec-Fetch-User: ?1' \
    -H 'Pragma: no-cache' \
    -H 'Cache-Control: no-cache' \
    --data-urlencode "Email=${email_address}" \
    --data-urlencode "CaptainName=${name_of_captain}" \
    --data-urlencode "CaptainName=${name_of_captain}" \
    --data-urlencode "GameDate=${start_date}" \
    --data-urlencode "What time was your game?=${start_time}" \
    --data-urlencode "WinStatus=${outcome}" \
    --data-urlencode "Opponents+number/color=${opposing_team_color}" \
    --data-urlencode "Score=${runs_scored}-${opposing_runs_scored}" \
    --data-raw '_returnTo=%2Freport-scores&formID=3&Sport=Softball+Indoor&Title+of+League=Monday-Wednesday+Coed&Team+number%2Fcolor=Silver&Comments='
}

main "$@"


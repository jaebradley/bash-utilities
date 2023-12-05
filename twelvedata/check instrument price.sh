#!/bin/bash

function main() {
  if [[ "2" != "$#" ]]; then printf "Expected two arguments, the instrument identifier (e.g. a stock ticker) and an API key\n" && exit 255; fi

  $(command -v "curl" &> /dev/null)
  if [[ "0" != "$?"  ]]; then printf "Unable to identify curl program\n" && exit 255; fi

  local -r instrument_identifier="$1"
  local -r api_key="$2"

  curl --silent --request GET --url "https://api.twelvedata.com/time_series?apikey=${api_key}&interval=1min&symbol=${instrument_identifier}&format=CSV&dp=2"  | awk -F ";" 'NR==2 { print $2 }'
}

main "$@"

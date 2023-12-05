#!/bin/bash

function main() {
  if [[ "1" != "$#" ]]; then printf "Expected one argument, the path to the jq executable\n" && exit 255; fi

  local -r jq_executable_location="$1"

  if [[ ! -e "${jq_executable_location}" ]]; then printf "jq executable at ${jq_executable_location} is not executable\n" && exit 255; fi

  $(command -v "curl" &> /dev/null)
  if [[ "0" != "$?"  ]]; then printf "Unable to identify curl program\n" && exit 255; fi

  local response
  response=$(curl --silent --request GET --url "https://production.dataviz.cnn.io/index/fearandgreed/graphdata" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Safari/605.1.15" -H 'Origin: https://www.cnn.com' -H 'Referrer:  https://www.cnn.com')
  if [[ "0" != "$?"  ]]; then printf "Unable to fetch fear and greed index data\n" && exit 255; fi

  local score
  score=$(printf "${response}" | "${jq_executable_location}" '.fear_and_greed.score | ceil')
  if [[ "0" != "$?"  ]]; then printf "Unable to parse fear and greed index score\n" && exit 255; fi

  local rating
  rating=$(printf "${response}" | "${jq_executable_location}" '.fear_and_greed.rating')
  if [[ "0" != "$?"  ]]; then printf "Unable to parse fear and greed index current rating\n" && exit 255; fi

  local last_week_rating
  last_week_rating=$(printf "${response}" | "${jq_executable_location}" '.fear_and_greed.previous_1_week | ceil')
  if [[ "0" != "$?"  ]]; then printf "Unable to parse fear and greed index for last week\n" && exit 255; fi

  local last_month_rating
  last_month_rating=$(printf "${response}" | "${jq_executable_location}" '.fear_and_greed.previous_1_month | ceil')
  if [[ "0" != "$?"  ]]; then printf "Unable to parse fear and greed index for last month\n" && exit 255; fi

  local last_year_rating
  last_year_rating=$(printf "${response}" | "${jq_executable_location}" '.fear_and_greed.previous_1_year | ceil')
  if [[ "0" != "$?"  ]]; then printf "Unable to parse fear and greed index for last year\n" && exit 255; fi

  printf "Score: ${score}\n"
  printf "Rating: ${rating}\n"
  printf "Last week's rating: ${last_week_rating}\n"
  printf "Last month's rating: ${last_month_rating}\n"
  printf "Last year's rating: ${last_year_rating}\n"
}

main "$@"

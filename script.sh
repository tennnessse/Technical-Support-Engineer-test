#!/bin/bash

# Ключ result 
result_url="https://api.etherscan.io/api?module=proxy&action=eth_blockNumber&apikey=YourApiKeyToken"

# Выполнение HTTP-запроса и извлечение значения 'result'
result=$(curl -s "$result_url" | jq -r '.result')

# Преобразование шестнадцатеричного значения 'result' в десятичное значение
result_10=$(printf "%d" "$result")

echo Значение result:$result_10

# Ключ height
height_url="https://api.blockcypher.com/v1/eth/main"

# Выполнение HTTP-запроса и извлечение значения 'height'
height=$(curl -s "$height_url" | jq -r '.height')

echo Значение height:$height

if (( result_10 > height )); then
  echo "Значение 'result' больше значения 'height'."
elif (( result_10 < height )); then
  echo "Значение 'result' меньше значения 'height'."
else
  echo "Значение 'result' равно значению 'height'."
fi

#!/bin/sh

docker build -q -t calculator .

output=$(printf "qwe \n rty \n fastest \n" | docker run -i --rm calculator)

expected_output='[
  {
    "origin_port": "qwe",
    "destination_port": "rty",
    "criteria": "fastest"
  }
]'

if [ "$output" == "$expected_output" ]; then
  echo "Test passed"
else
  echo "Test failed"
  echo "Expected output:"
  echo $expected_output
  echo "Actual output:"
  echo $output
fi

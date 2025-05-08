#!/bin/sh

docker build -q -t calculator .

output=$(printf "qwe\nrty\n123\n" | docker run -i --rm calculator)

expected_output='[
  {
    "origin_port": "qwe",
    "destination_port": "rty",
    "criteria": "123"
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

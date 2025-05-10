#!/bin/sh

super_duper_function_to_run_the_test() {
  local actual_output="$1"
  local expected_output="$2"

  if [ "$output" == "$expected_output" ]; then
    echo "Test passed"
  else
    echo "Test failed"

    echo "Expected output:"
    echo $expected_output

    echo "Actual output:"
    echo $actual_output
  fi
}

docker build -q -t calculator .

# Test for "CNSHA \n NLRTM \n cheapest-direct \n"
output=$(printf "CNSHA \n NLRTM \n cheapest-direct \n" | docker run -i --rm calculator)
expected_output='[
  {
    "origin_port": "CNSHA",
    "destination_port": "NLRTM",
    "departure_date": "2022-02-01",
    "arrival_date": "2022-03-01",
    "sailing_code": "ABCD",
    "rate": "589.30",
    "rate_currency": "USD"
  }
]'
super_duper_function_to_run_the_test "$output" "$expected_output"

# Test for "qwe \n rty \n fastest \n"
output=$(printf "qwe \n rty \n fastest \n" | docker run -i --rm calculator)
expected_output='[
  {
    "origin_port": "qwe",
    "destination_port": "rty",
    "criteria": "fastest"
  }
]'

super_duper_function_to_run_the_test "$output" "$expected_output"

# Test for "qwe \n rty \n cheapest \n"
output=$(printf "qwe \n rty \n cheapest \n" | docker run -i --rm calculator)
expected_output='[
  {
    "origin_port": "qwe",
    "destination_port": "rty",
    "criteria": "cheapest"
  }
]'
super_duper_function_to_run_the_test "$output" "$expected_output"

# Test for "qwe \n rty \n coolest \n"
output=$(printf "qwe \n rty \n coolest \n" | docker run -i --rm calculator)
expected_output="Invalid input"

super_duper_function_to_run_the_test "$output" "$expected_output"

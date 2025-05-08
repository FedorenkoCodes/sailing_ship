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

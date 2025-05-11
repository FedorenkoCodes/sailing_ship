#!/bin/sh

super_duper_function_to_run_the_test() {
  actual_output="$1"
  expected_output="$2"

  if [ "$output" = "$expected_output" ]; then
    echo "Test passed"
  else
    echo "Test failed"

    echo "Expected output:"
    echo "$expected_output"

    echo "Actual output:"
    echo "$actual_output"
  fi
}

docker build -q -t calculator .

# Test for "CNSHA \n NLRTM \n cheapest-direct \n"
output=$(printf "CNSHA \n NLRTM \n cheapest-direct \n" | docker run -i --rm calculator)
expected_output='[
  {
    "origin_port": "CNSHA",
    "destination_port": "NLRTM",
    "departure_date": "2022-01-30",
    "arrival_date": "2022-03-05",
    "sailing_code": "MNOP",
    "rate": "456.78",
    "rate_currency": "USD"
  }
]'
super_duper_function_to_run_the_test "$output" "$expected_output"

# Test for "CNSHA \n NLRTM \n fastest \n"
output=$(printf "CNSHA \n NLRTM \n fastest \n" | docker run -i --rm calculator)
expected_output='[
  {
    "origin_port": "CNSHA",
    "destination_port": "ESBCN",
    "departure_date": "2022-01-29",
    "arrival_date": "2022-02-12",
    "sailing_code": "ERXQ",
    "rate": "261.96",
    "rate_currency": "EUR"
  },
  {
    "origin_port": "ESBCN",
    "destination_port": "NLRTM",
    "departure_date": "2022-02-16",
    "arrival_date": "2022-02-20",
    "sailing_code": "ETRG",
    "rate": "69.96",
    "rate_currency": "USD"
  }
]'

super_duper_function_to_run_the_test "$output" "$expected_output"

# Test for "CNSHA \n NLRTM \n cheapest \n"
output=$(printf "CNSHA \n NLRTM \n cheapest \n" | docker run -i --rm calculator)
expected_output='[
  {
    "origin_port": "CNSHA",
    "destination_port": "ESBCN",
    "departure_date": "2022-01-29",
    "arrival_date": "2022-02-12",
    "sailing_code": "ERXQ",
    "rate": "261.96",
    "rate_currency": "EUR"
  },
  {
    "origin_port": "ESBCN",
    "destination_port": "NLRTM",
    "departure_date": "2022-02-16",
    "arrival_date": "2022-02-20",
    "sailing_code": "ETRG",
    "rate": "69.96",
    "rate_currency": "USD"
  }
]'
super_duper_function_to_run_the_test "$output" "$expected_output"

# Test for "qwe \n rty \n coolest \n"
output=$(printf "qwe \n rty \n coolest \n" | docker run -i --rm calculator)
expected_output="Invalid input"

super_duper_function_to_run_the_test "$output" "$expected_output"

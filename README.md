# Shipment Calculator Ruby Script

This project contains a Ruby script that performs calculations of shipment prices. The script can be built and run using Docker.

## Prerequisites

- Docker installed on your machine

## Building the Docker Image

To build the Docker image, run the following command in the project directory:

```
docker build -t calculator .
```

## Running the Docker Container

To run the Docker container, use the following command:

```
docker run -it calculator
```

This will start the container and execute the Ruby script.
User is expected to enter the code of origin port and confirm their input with the Enter key. After that the coee of destination port is expected, and the criteria (with cheapest-direct, cheapest, fastest as available options).

## Testing

To run test, use the following command:

```
./test_script.sh
```

This will run the only test I've made up just to try it out.

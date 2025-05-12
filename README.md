# Shipment Calculator Ruby Script

This project contains a Ruby script that finds sailings based on search criteria. The script can be built and run using Docker.

## Assumptions

Team MapReduce provides a valid response.json file, hence I assume that it is valid.

The response.json is not big, and it is easy to read so it is re-parsed every time the script is run.

User of the tool knows their ports and there is no check if ports actually exist in the file.

The actual amount of sailings and possible legs are not big, so everything is done im-memory with simple loops.

This code is intended to be minimalistic and simple to fit the definition of a 'small service'.

## Prerequisites

- Docker installed on your machine
- Terminal
- You are an engineering manager or hiring manager who are paid for looking at this kind of stuff

## Building the Docker Image

To build the Docker image, run the following command in the project directory:

```
docker build -t calculator .
```

## Running the Docker Container

To run the Docker container, use the following command:

```
docker run -it --rm calculator
```

This will start the container and execute the Ruby script.
User is expected to enter the code of origin port and confirm their input with the Enter key. After that the coee of destination port is expected, and the criteria (with cheapest-direct, cheapest, fastest as available options).

## Testing

To run test, use the following command:

```
./test_script.sh
```

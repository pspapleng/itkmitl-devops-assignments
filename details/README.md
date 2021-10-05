# How to run details service


## Prerequisite

* Ruby 2.7

```bash
ruby details.rb 9080
```


## How to run with Docker

```bash
# Build Docker Image for details service
docker build -t details .

# Run details service on port 8081
docker run -d --name details -p 8081:9080 details
```

* Test with path `/details/1` and `/health`


## How to run with Docker Compose

```bash
docker-compose up
```
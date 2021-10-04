#!/bin/bash

docker build -t ratings ~/ratings

docker run -d --name mongodb -p 27017:27017 -e 'MONGODB_USERNAME=ratings' -e 'MONGODB_PASSWORD=CHANGEME' -e 'MONGODB_DATABASE=ratings' \
  -v $(pwd)/databases:/docker-entrypoint-initdb.d bitnami/mongodb:5.0.2-debian-10-r2

docker run -d --name ratings -p 8080:8080 --link mongodb:mongodb -e SERVICE_VERSION=v2 \
  -e 'MONGO_DB_URL=mongodb://mongodb:27017/ratings' -e 'MONGO_DB_USERNAME=ratings' -e 'MONGO_DB_PASSWORD=CHANGEME' ratings


docker build -t details ~/itkmitl-bookinfo-details
docker run -d --name details -p 8081:9080 details


docker build -t reviews ~/itkmitl-bookinfo-reviews
docker run -d --name reviews -p 8082:9080 --link ratings -e 'RATINGS_SERVICE=http://ratings:8080' -e 'ENABLE_RATINGS=true' reviews


docker build -t productpage ~/itkmitl-bookinfo-productpage
docker run -d --name productpage -p 8083:9080 --link ratings --link details --link reviews -e 'RATINGS_HOSTNAME=http://ratings:8080' -e 'DETAILS_HOSTNAME=http://details:9080' -e 'REVIEWS_HOSTNAME=http://reviews:9080' productpage
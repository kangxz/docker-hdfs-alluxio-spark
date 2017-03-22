#!/usr/bin/env bash

node=${1:-0}
master=${2:-"spark-master"}
namenode=${3:-"namenode"}

createNetwork() {
  sudo docker network inspect alluxio > /dev/null 2>&1

  if [ $? -eq 1 ]; then
    local network=$(sudo docker network create alluxio)
    echo "Created network alluxio $network"
  fi
}

createNetwork

sudo docker run -d --network=alluxio --name spark-worker${node} -h spark-worker${node} spark slave start ${master}
#!/bin/bash

export CONSUL_ADDR=http://127.0.0.1:8500

curl -X GET \
    ${CONSUL_ADDR}/v1/agent/members | jq '.' # Retrieve Consul members

curl -X PUT \
      -d 'myid=hashiapj' \
      ${CONSUL_ADDR}/v1/kv/api | jq '.' # Write a KV

curl -X GET \
      ${CONSUL_ADDR}/v1/kv/api | jq '.' # Read a KV

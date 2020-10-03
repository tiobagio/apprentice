#!/bin/bash

#export VAULT_ADDR=http://vault.service.vault:8200
export VAULT_ADDR=http://127.0.0.1:8200

curl \
    -H "X-Vault-Token: ${VAULT_TOKEN}" \
    -X POST \
    -d '{"data": {"foo":"bar"}}' \
    ${VAULT_ADDR}/v1/mysecret/data/mysql | jq '.' # Write a KV secret

curl -H "X-Vault-Token: ${VAULT_TOKEN}" \
    ${VAULT_ADDR}/v1/mysecret/data/mysql | jq '.' # Read a KV secret

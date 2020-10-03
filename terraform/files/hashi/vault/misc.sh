#!/bin/bash

export VAULT_TOKEN=s.lUCk4dM00abFLKvNluqnpJ58

## POLICY
vault policy write viewer ~/hashi/vault/viewer.hcl

## TOKEN
vault token create -ttl=1h -policy=viewer
vault token lookup

## Database
vault read database/creds/datareader

vault read database/creds/datawriter


## KV
vault kv put mysecret/mysql foo=bar
vault kv get mysecret/mysql


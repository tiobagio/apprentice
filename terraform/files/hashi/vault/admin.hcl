
# List, create, update, and delete key/value secrets
path "mysecret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "database/creds/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}



# List, create, update, and delete key/value secrets
path "mysecret/mysql"
{
  capabilities = ["read", "list"]
}

path "database/creds/datareader"
{
  capabilities = ["read", "list"]
}




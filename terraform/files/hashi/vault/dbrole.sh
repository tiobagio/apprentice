#!/bin/bash

config_vault_database() {

vault secrets enable database

vault write database/config/tiosql plugin_name=mysql-database-plugin connection_url="{{username}}:{{password}}@tcp(127.0.0.1:3306)/"  allowed_roles="datareader,datawriter" username="root" password="R31nsta11@"

# vault write database/config/tiosql plugin_name=mysql-database-plugin connection_url="{{username}}:{{password}}@tcp(127.0.0.1:3306)/" \
#root_rotation_statements="SET PASSWORD = PASSWORD('{{password}}')" \
#    allowed_roles="datareader,datawriter" \
#    username="root" \
#    password="R31nsta11@"


# project viewer
vault write database/roles/datareader db_name=tiosql \
creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}'; GRANT SELECT ON test.* TO '{{name}}'@'%';" \
default_ttl="10m" max_ttl="24h"


# project owner
vault write database/roles/datawriter db_name=tiosql \
creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}'; GRANT ALL ON test.* TO '{{name}}'@'%';" \
default_ttl="10m" max_ttl="24h"

}

config_vault_database
#vault read database/creds/datareader
#vault read database/creds/datawriter


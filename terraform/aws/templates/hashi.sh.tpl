config_vault() {
    echo "***** Configure Vault *****"

    vault_pid=`ps -ef |grep 'vault server' |grep -v grep |awk '{print $2}'`
    sudo kill -9 $vault_pid

    # recreating /opt/vault/data
    #
    sudo rm -rf /opt/vault/data
    sudo mkdir /opt/vault/data
    sudo chown vault:vault /opt/vault/data

    sudo cp ~/hashi/vault/simple.hcl /etc/vault.d
    sudo chown vault:vault /etc/vault.d/simple.hcl

    # server
#    vault server -config=/home/ec2-user/hashi/vault-config/simple.hcl
    sudo rm -rf /etc/vault.d/vault.log
sudo runuser -l vault -c "vault server -config=/etc/vault.d/simple.hcl > /etc/vault.d/vault.log 2>&1 &"
    sleep 5
    # unseal
    export VAULT_ADDR="http://127.0.0.1:8200"
    vault operator init > key.txt
    vault operator unseal $(grep 'Key 1:' key.txt | awk '{print $NF}')
    vault operator unseal $(grep 'Key 2:' key.txt | awk '{print $NF}')
    vault operator unseal $(grep 'Key 3:' key.txt | awk '{print $NF}')
    vault login $(grep 'Initial Root Token:' key.txt | awk '{print $NF}')

    token=`grep 'Initial Root Token:' key.txt | awk '{print $NF}'`
    export VAULT_TOKEN=$token 
    echo export VAULT_TOKEN=$token >> ~/.bash_profile

    #audit
    #vault audit enable file file_path=/var/log/vault_audit.log

}

config_vault_kv() {
    echo "***** Configure Vault kv secret  *****"

    vault secrets enable -path=mysecret kv
    vault secrets list
    pwd=`sudo grep 'root@localhost:' /var/log/mysqld.log |awk '{print $NF}'`

    vault kv put mysecret/mysql root_password="$pwd" root_new_password="{mysql_password}"
    vault kv get mysecret/mysql
}

config_vault_database() {
    echo "***** Configure Vault database secret  *****"

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

#vault read database/creds/datareader
#vault read database/creds/datawriter

}

config_consul() {
    echo "***** Configure Consul  *****"

    consul_pid=`ps -ef |grep 'consul agent -dev' |grep -v grep |awk '{print $2}'`
    sudo kill -9 $consul_pid

    sudo cp ~/hashi/consul/php.json /etc/consul.d/php.json
    sudo cp ~/hashi/consul/mysql.json /etc/consul.d/mysql.json
    sudo chown consul:consul /etc/consul.d/*.json

    sudo rm -f /etc/consul.d/consul.log
    sudo runuser -l consul -c "consul agent -dev -client 0.0.0.0 -config-dir=/etc/consul.d > /etc/consul.d/consul.log 2>&1 &" 
    sleep 5

    consul members

    #consul connect proxy -sidecar-for mysql
    #consul connect proxy -sidecar-for counting
    #consul connect proxy -service foo -upstream mysql:5000
}

untar_apprentice() {
    echo "***** Untar apprentice.tgz *****"
    mv ~/hashi ~/hashi_old
    tar -xzvf ~/apprentice.tgz
}

config_httpd() {
    echo "***** Configure mysql *****"

    sudo cp ~/hashi/html/*.php /var/www/html
}

config_mysqld() {
    echo "***** Reset mysqld root *****"

    pwd=`sudo grep 'root@localhost:' /var/log/mysqld.log |awk '{print $NF}'`

    #sudo systemctl stop mysqld
    #sudo mysqld -init-file=~/hashi/sql/reset.sql
    #sudo systemctl start mysqld
    #mysql -u root -p"B@wean9Sit" < ~/hashi/sql/reset.sql
    mysql -u root -p\"$pwd\" <<EOF 
SET GLOBAL validate_password.policy=0;
update mysql.user set authentication_string=PASSWORD('B@rbi3Girl') where user='root';
flush privileges;
exit
EOF

}


untar_apprentice

config_vault
config_vault_kv
#config_vault_database
config_consul
config_httpd
#config_mysqld

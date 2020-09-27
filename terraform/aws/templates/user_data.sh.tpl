install_hashi() {
    echo "***** Install Hashicorp Vault and Consul *****"
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum -y install vault
    sudo yum -y install consul
    which vault
    which consul
}

install_utilities() {
    echo "***** Install Utilities *****"

    sudo yum -y install ss
    sudo yum install -y bind-utils
    sudo yum install -y git
}


install_httpd() {
    echo "***** Install httpd *****"

    sudo yum -y install httpd
    sudo yum -y install php php-mysql
    sudo systemctl enable --now httpd

    sudo setsebool -P httpd_can_network_connect=1
}

install_mysqld() {
    echo "***** Install mysqld *****"

    sudo sudo rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
    sudo sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
    sudo yum --enablerepo=mysql57-community install -y mysql-community-server

    sudo systemctl start mysqld.service
}


config_env() {
    echo "***** Configure bash profile *****"
    # AWS uses IAM
    echo export AWS_REGION=us-west-1  >> ~/.bash_profile

    echo export LANG=en_US.UTF-8 >> ~/.bash_profile
    echo export LANGUAGE=en_US.UTF-8 >> ~/.bash_profile
    echo export LC_COLLATE=C >> ~/.bash_profile
    echo export LC_CTYPE=en_US.UTF-8 >> ~/.bash_profile

    echo export VAULT_ADDR="http://127.0.0.1:8200" >> ~/.bash_profile
    #echo export VAULT_CACERT="/home/ec2-user/hashi/vault-coonfig/server.crt" >> ~/.bash_profile
}

change_hashiuser() {
	sudo usermod --shell /bin/bash consul
	sudo usermod --shell /bin/bash vault
	sudo mkdir -p /home/consul
	sudo chown consul:consul /home/consul

	sudo mkdir -p /home/vault
	sudo chown vault:vault /home/vault
}

#install_hashi
#install_httpd
#install_mysqld
#install_utilities
#config_env
change_hashiuser

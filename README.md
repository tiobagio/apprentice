# Apprentice - Create Demo Environment

### About
This repo creates a Demo Environment to teach Hashicorp Vault and Consul Essentials. It creates the following under one machine:
- Vault
    - Creates Database dynamic secrets, each with different roles
    - Enables KV Secret Engine
- Consul
    - Creates services for Web and Database
    - Secure communications between Web and DB using mutual TLS (mTLS)
    - Creates Intentions to control which services may establish connections.
- HTTPD
- MySQL
    - Change the root password
    - Creates test databases and users


### Step 1 - Get Started
First you need the code !
```bash
git clone https://github.com/tiobagio/apprentice

cd apprentice
```

#### Configure your variables.tfvars file from the example
Modify a variables.tfvars file from the example and populate appropriately,
including the new root password for mysql.

### Create the Chef Training Environment
```bash
cd terraform/aws/
```

Execute the terraform. First run the initialise to ensure the plugins you need are installed:

```bash
terraform init
```
Before you run Terraform to create your infrastructure, it's a good idea to see what resources it would create. It also helps you verify that Terraform can connect to your AWS account.

```bash
terraform plan
```

and then apply to create the infrastructure.

```bash
terraform apply -auto-approve
```

### What does it create ?

It will create the following servers
- RHEL VM with HTTP and MySQL, as well as HashiCorp Vault and Consul single deployment servers.

Once successfully created, you will get an output like this:

### Debuging

#### Rerun for Just One Resource
Set the log level
```bash
export TF_LOG=TRACE
```

Push the ```terraform``` output to a file
```bash
export TF_LOG_PATH=./terraform.log
```

"Taint" the resource for recreation.  You can pass any resource name to the `taint` command
```bash
terraform taint aws_instance.linux-node
terraform taint "aws_instance.linux-node[0]"
```

Then `apply` to recreate any resource you marked as tainted.
```bash
terraform apply
```

## License and Author

* Authors: Tio Bagio


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

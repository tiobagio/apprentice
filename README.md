# Apprentice - Create Demo Environment

### About
This repo creates a Demo Environment to teach Hashicorp Vault and Consul Essentials. It creates the following under one machine:
- Vault
    - InSpec Profiles
    - Creates 10 local users for the students
- Consul
    - Creates user pem and org validator
    - Habitat OnPrem Builder

#### Other Resources
This environment is made to work with the following:
1. [Complaince Workshop Training Repo](https://github.com/anthonygrees/compliance-workshop)
2. [Policyfiles training](https://github.com/anthonygrees/policyfiles_training)
3. [Remote InSpec Scanning](https://github.com/chef-cft/inspec-remote-scanning) (See here for - [Setup](REMOTE-SCAN-SETUP.md))


### Step 1 - Get Started
First you need the code !
```bash
git clone https://github.com/chef-cft/apprentice-chef

cd apprentice-chef
```

#### MySQL Credentials
User - `chef`
Password - ```set by variable```

#### Configure your terraform.tfvars file from the example
Create a terrform.tfvars file from the example and populate appropriately

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
- Ubuntu VM with Chef Automate, Chef Infra Server and Habitat On Prem Builder
- Windows Student workstation (1 for each student)

Once successfully created, you will get an output like this:
![TerraformOutput](/images/automate_output.png)

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
terraform taint aws_iam_role.apprentice_role
terraform taint "aws_instance.workstation[0]"
```

Then `apply` to recreate any resource you marked as tainted.
```bash
terraform apply
```

## License and Author

* Authors:: 
- Tio Bagio


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

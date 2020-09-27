////////////////////////////////
// AWS Connection

////////////////////////////////
// AWS

variable "aws_region" { default = "us-west-1" }
variable "aws_profile" { default = "yentio" }
variable "aws_credentials_file" { default = "~/.aws/credentials" }
variable "aws_key_pair_name" { default = "yentio-ca" } 
variable "aws_key_pair_file" { default = "~/.ssh/yentio-ca.pem" }
//variable "aws_ami_id"   { default = "ami-6f68cf0f" 
//variable "ami_name"     { default = "RHEL-7.3_HVM_GA-*" } # Base RHEL name
variable "aws_ami_id"   { default = "ami-0388d197bb42be9be" } 
variable "ami_name"     { default = "RHEL-7.7_HVM_GA-*" } # Base RHEL name
variable "ami_owner"    { default = "309956199498" } # Base RHEL owner


////////////////////////////////
// Nodes

variable "node_counter" { default = "0" }
variable "linux_node_instance_type" { default = "t3.medium" }


////////////////////////////////
// Object Tags

variable "tag_customer" { default = "apjcorp" } 
variable "tag_project" { default = "demo" }
variable "tag_name" { default = "" }
variable "tag_dept" { default = "default" }
variable "tag_contact" { default = "tbagio@gmail.com" }
variable "tag_application" { default = "default" }
variable "tag_ttl" { default = 4 }


////////////////////////////////
// Some Other  Variables

variable "mysql_password" { description = "root password to replace system generated one" }



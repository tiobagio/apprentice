terraform {
  required_version = "~> 0.12.24" 
}

provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile
  shared_credentials_file = var.aws_credentials_file
}

locals {
  common_tags = {
    Name          = "${var.tag_name}-vpc"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }
}

resource "random_id" "random" {
  byte_length = 4
}


////////////////////////////
// Instance
//  ami                    = "ami-09032db74f79eea11"
// count                  = var.node_counter

resource "aws_instance" "linux-node" {
  instance_type          = "t3.medium"
  ami                    = var.aws_ami_id
  key_name               = var.aws_key_pair_name
  private_ip             = "172.31.54.130"
  subnet_id              = aws_subnet.apprentice_subnet_a.id
  vpc_security_group_ids = [aws_security_group.apprentice.id]
  ebs_optimized          = true
  associate_public_ip_address = true

  connection {
    user        = "ec2-user"
    private_key = file(var.aws_key_pair_file)
    host        = self.public_ip
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "apprentice-linux-${random_id.random.hex}"
    }
  )

  provisioner "file" {
    content     = templatefile("${path.module}/templates/user_data.sh.tpl", { mysql_password = var.mysql_password, aws_region = var.aws_region })
    destination = "/tmp/user_data.sh"
  }

  provisioner "file" {
    content     = templatefile("${path.module}/templates/hashi.sh.tpl", {
mysql_password = var.mysql_password, aws_region = var.aws_region,  })
    destination = "/tmp/hashi.sh"
  }

  provisioner "file" {
    source     = "${path.module}/files/apprentice.tgz"
    destination = "/home/ec2-user/apprentice.tgz"
}
  provisioner "remote-exec" {
    inline = [
      "bash -x /tmp/user_data.sh"
    ]
  }

}

////////////////////////////
// VPC
resource "aws_vpc" "apprentice_vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = merge(
    local.common_tags,
    {
      "Name" = "apprentice-vpc-${random_id.random.hex}"
    }
  )
}

resource "aws_internet_gateway" "apprentice_gw" {
  vpc_id = aws_vpc.apprentice_vpc.id

  tags = merge(
    local.common_tags,
    {
      "Name" = "apprentice-gw-${random_id.random.hex}"
    }
  )
}

resource "aws_route" "apprentice_default_route" {
  route_table_id         = aws_vpc.apprentice_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.apprentice_gw.id
}

resource "aws_subnet" "apprentice_subnet_a" {
  vpc_id                  = aws_vpc.apprentice_vpc.id
  cidr_block              = "172.31.54.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}a"

  tags = merge(
    local.common_tags,
    {
      "Name" = "apprentice-subnet-a-${random_id.random.hex}"
    }
  )
}

resource "aws_subnet" "apprentice_subnet_b" {
  vpc_id                  = aws_vpc.apprentice_vpc.id
  cidr_block              = "172.31.55.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}b"

  tags = merge(
    local.common_tags,
    {
      "Name" = "apprentice-subnet-b-${random_id.random.hex}"
    }
  )
}

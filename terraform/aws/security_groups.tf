resource "aws_security_group" "apprentice" {
  name   = "apprentice-sg-${random_id.random.hex}"
  vpc_id = aws_vpc.apprentice_vpc.id

  tags = merge(
    local.common_tags,
    {
      "Name" = "apprentice-sg-${random_id.random.hex}"
    }
  )
}

#SSH
resource "aws_security_group_rule" "apprentice_ingress_allow_22_tcp" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

# RDP
resource "aws_security_group_rule" "apprentice_ingress_allow_3389_tcp" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

# WinRM
resource "aws_security_group_rule" "apprentice_ingress_allow_5985_tcp" {
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

// Vault UI
resource "aws_security_group_rule" "apprentice_ingress_allow_8200_tcp" {
  type              = "ingress"
  from_port         = 8200
  to_port           = 8200
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

// Consul UI
resource "aws_security_group_rule" "apprentice_ingress_8500_tcp" {
  type              = "ingress"
  from_port         = 8500
  to_port           = 8500
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}


# HTTP/S
resource "aws_security_group_rule" "apprentice_ingress_allow_80_tcp" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

resource "aws_security_group_rule" "apprentice_ingress_allow_443_tcp" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

resource "aws_security_group_rule" "apprentice_ingress_allow_8080_tcp" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

resource "aws_security_group_rule" "apprentice_egress_allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

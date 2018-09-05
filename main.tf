# Outbound rule! Currently attached to admin SG only

resource "aws_security_group_rule" "outbound" {
  type        = "egress"
  from_port   = -1
  to_port     = -1
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.admin_sg.id}"
}

# Admin SG
#
#
resource "aws_security_group" "admin_sg" {
  name        = "Core_System_Admin"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "anti-virus" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "739672810541/sg-ce54c4b3"
  description              = "Anti-virus"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

resource "aws_security_group_rule" "darktrace" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "739672810541/sg-585aca25"
  description              = "Darktrace"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

resource "aws_security_group_rule" "domains_controllers" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "739672810541/sg-c4ad3db9"
  description              = "Domain Controllers"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

resource "aws_security_group_rule" "monitoring" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "739672810541/sg-9b50c0e6"
  description              = "Monitoring"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

resource "aws_security_group_rule" "patching" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "739672810541/sg-6350c01e"
  description              = "Patching"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

resource "aws_security_group_rule" "ansible" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "739672810541/sg-916cfcec"
  description              = "Ansible"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

resource "aws_security_group_rule" "ping" {
  type        = "ingress"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["10.0.0.0/8"]
  description = "Internal Ping"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

resource "aws_security_group_rule" "dynamic" {
  type        = "ingress"
  from_port   = 49152
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]
  description = "Dynamic Port Range"

  security_group_id = "${aws_security_group.admin_sg.id}"
}

# Remote Access
#
#

resource "aws_security_group" "remote_access_sg" {
  name        = "Core_Remote_Access"
  description = "Allows remote access - SSH and RDP - from local network"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "SSH" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]
  description = "Internal SSH"

  security_group_id = "${aws_security_group.remote_access_sg.id}"
}

resource "aws_security_group_rule" "RDP" {
  type        = "ingress"
  from_port   = 3389
  to_port     = 3389
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]
  description = "Internal RDP"

  security_group_id = "${aws_security_group.remote_access_sg.id}"
}

# Public Web Server
#
#

resource "aws_security_group" "open_http_https_sg" {
  name        = "Core_HTTP_HTTPS_All"
  description = "Allows open access from HTTP and HTTPS from anywhere"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "HTTP_Open" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.open_http_https_sg.id}"
}

resource "aws_security_group_rule" "HTTPS_Open" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.open_http_https_sg.id}"
}

resource "aws_security_group" "internal_http_https_sg" {
  name        = "Core_HTTP_HTTPS_Internal"
  description = "Allows open access from HTTP and HTTPS from anywhere"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "HTTP_Internal" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]

  security_group_id = "${aws_security_group.open_http_https_sg.id}"
}

resource "aws_security_group_rule" "HTTPS_Internal" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]

  security_group_id = "${aws_security_group.open_http_https_sg.id}"
}

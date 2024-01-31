variable "vpc_id" {
  type = string
}

output "security_groups" {
  value = [aws_security_group.allow_nomad_port.id]
}

resource "aws_security_group" "allow_nomad_port" {
  name   = "allow_nomad_port"
  vpc_id = var.vpc_id

  tags = {
    Name = "allow_nomad_port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_api" {
  security_group_id = aws_security_group.allow_nomad_port.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 4646
  ip_protocol       = "tcp"
  to_port           = 4646
}

resource "aws_vpc_security_group_ingress_rule" "rpc" {
  security_group_id = aws_security_group.allow_nomad_port.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 4647
  ip_protocol       = "tcp"
  to_port           = 4647
}

resource "aws_vpc_security_group_ingress_rule" "serf_wan_tcp" {
  security_group_id = aws_security_group.allow_nomad_port.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 4648
  ip_protocol       = "tcp"
  to_port           = 4648
}

resource "aws_vpc_security_group_ingress_rule" "serf_wan_udp" {
  security_group_id = aws_security_group.allow_nomad_port.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 4648
  ip_protocol       = "udp"
  to_port           = 4648
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_nomad_port.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_nomad_port.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
locals {
  subnets         = cidrsubnets(var.cidr_block, 2, 2, 2, 2)
  subnets_private = slice(local.subnets, 0, 2)
  subnets_public  = slice(local.subnets, 2, 4)
}

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "${var.resource_name}-vpc"
  }
}

resource "aws_subnet" "private" {
  for_each   = { for key, value in local.subnets_private : key => value }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = {
    Name = "${var.resource_name}-private-subnet-${each.key + 1}"
  }
}

resource "aws_route_table_association" "rt_association_private" {
  for_each       = { for key, value in aws_subnet.private : key => value }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_subnet" "public" {
  for_each   = { for key, value in local.subnets_public : key => value }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = {
    Name = "${var.resource_name}-public-subnet-${each.key + 1}"
  }
}

resource "aws_route_table_association" "rt_association_public" {
  for_each       = { for key, value in aws_subnet.public : key => value }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
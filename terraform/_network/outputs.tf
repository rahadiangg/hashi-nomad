output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = [for v in aws_subnet.private : v.id]
}

output "public_subnet_ids" {
  value = [for v in aws_subnet.public : v.id]
}

output "availability_zones" {
  value = [for k, v in local.subnets_private : "${var.region}${local.zone[k]}"]
}
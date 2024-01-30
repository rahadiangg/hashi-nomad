output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = [for v in aws_subnet.private:v.id ]
}

output "public_subnet_ids" {
  value = [for v in aws_subnet.public: v.id ]
}
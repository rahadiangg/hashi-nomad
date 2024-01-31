data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "random_shuffle" "ec2_placement" {
  input        = var.subnets
  result_count = var.instance_count
}

resource "random_string" "ec2_name" {
  count = var.instance_count
  length = 5
  lower = true
  upper = false
  special = false
}

resource "aws_instance" "ec2" {
  count = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = random_shuffle.ec2_placement.result[count.index]

  tags = {
    Name = "ec2-${random_string.ec2_name[count.index].result}"
  }
}
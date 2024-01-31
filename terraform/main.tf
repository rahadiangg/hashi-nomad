provider "aws" {
  access_key = var.aws_ak
  secret_key = var.aws_sk
  region     = local.nomad_client_region
  alias = "nomad_client_jakarta"
}

locals {
  nomad_client_region = "ap-southeast-3"
}

module "nomad_client" {
  source        = "./_network"
  resource_name = "nomad_client"
  region        = local.nomad_client_region
  providers = {
    aws = aws.nomad_client_jakarta
  }
}

module "nomad_client_ec2" {
  source         = "./_ec2"
  instance_count = 2
  subnets        = module.nomad_client.public_subnet_ids
  instance_type  = "t3.micro"
  providers = {
    aws = aws.nomad_client_jakarta
  }
}
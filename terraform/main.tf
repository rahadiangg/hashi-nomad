provider "aws" {
  access_key = var.aws_ak
  secret_key = var.aws_sk
  region     = "ap-southeast-3"
}

module "nomad_client" {
  source = "./_network"
  resource_name = "nomad_client"
}

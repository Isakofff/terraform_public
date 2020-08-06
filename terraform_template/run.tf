provider "aws" {
  region = var.main-region
  access_key = var.AK
  secret_key = var.SK
}

module "aws-s3" {
  source = "./modules/storage"
  bucket_name = var.bucket_name
}

module "aws-vpc" {
  source = "./modules/network"
  AZs         = var.AZs
}

module "aws-instances" {
  source = "./modules/instances"
  golden_ami          = var.golden_ami
  key_name            = var.key_name
  AZs                 = var.AZs
  dev-list-of-target  = var.dev-list-of-target
  subnet1             = module.aws-vpc.subnet1
  security_group      = module.aws-vpc.security_group
}

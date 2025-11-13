# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
#
#   required_version = ">= 1.6.0"
# }

# module "s3_backend" {
#   source      = "./modules/s3-backend"
#   bucket_name = "my-avoo-bucket-terraform"
#   table_name  = "terraform-locks"
# }

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  private_subnets = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name       = "hw-vpc"
}

# module "ecr" {
#   source       = "./modules/ecr"
#   ecr_name     = "hw-ecr"
#   scan_on_push = true
# }

module "eks" {
  source          = "./modules/eks"
  cluster_name    = "eks-cluster-avoo"
  subnet_ids      = module.vpc.public_subnets
  instance_type   = "t3.micro"
  desired_size    = 2
  max_size        = 4
  min_size        = 2
}

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
  source        = "./modules/eks"
  cluster_name  = "eks-cluster-avoo"
  subnet_ids    = module.vpc.public_subnets
  instance_type = "t3.small"
  desired_size  = 4
  max_size      = 12
  min_size      = 2
}

data "aws_eks_cluster" "eks" {
  name = module.eks.eks_cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.eks_cluster_name
  depends_on = [module.eks]
}

# provider "kubernetes" {
#   alias = "eks"
#   host  = data.aws_eks_cluster.eks.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
#   token = data.aws_eks_cluster_auth.eks.token
# }
#
# provider "helm" {
#   kubernetes = {
#     host  = data.aws_eks_cluster.eks.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
#     token = data.aws_eks_cluster_auth.eks.token
#   }
# }


provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

module "jenkins" {
  source       = "./modules/jenkins"
  cluster_name = module.eks.eks_cluster_name
  providers = {
    helm = helm
  }
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url

  depends_on = [module.eks]
}


module "argo_cd" {
  source        = "./modules/argo-cd"
  namespace     = "argocd"
  chart_version = "5.46.4"
}


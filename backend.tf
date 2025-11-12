# terraform {
#   backend "s3" {
#     bucket         = "my-avoo-bucket-terraform"
#     key            = "hw/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

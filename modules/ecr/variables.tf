variable "ecr_name" {
  type        = string
  description = "Name of ECR repository"
}

variable "scan_on_push" {
  type        = bool
  description = "Scan on push configuration for ECR repository"
}

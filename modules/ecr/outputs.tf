output "ecr_name" {
  description = "Name of ECR repository"
  value       = aws_ecr_repository.ecr.name
}

output "ecr_id" {
  description = "ID of ECR repository"
  value       = aws_ecr_repository.ecr.id
}

output "repository_url" {
  value       = aws_ecr_repository.ecr.repository_url
  description = "URL of the ECR repository"
}

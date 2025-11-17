variable "rds_use_aurora" {
  description = "Use Aurora for the RDS database"
  type        = bool
  default     = false
}
variable "rds_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "postgres"
}
variable "rds_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
  default = "test12345"
}
variable "rds_database_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "myapp"
}
variable "rds_publicly_accessible" {
  description = "Whether the RDS database should be publicly accessible"
  type        = bool
  default     = false
}
variable "rds_multi_az" {
  description = "Enable Multi-AZ for the RDS database"
  type        = bool
  default     = true
}
variable "rds_instance_class" {
  description = "Instance class for the RDS database"
  type        = string
  default     = "db.t3.micro"
}
variable "rds_aurora_engine" {
  description = "Engine for Aurora RDS"
  type        = string
  default     = "aurora-postgresql"
}
variable "rds_aurora_engine_version" {
  description = "Engine version for Aurora RDS"
  type        = string
  default     = "15.3"
}
variable "rds_aurora_parameter_group_family" {
  description = "Parameter group family for Aurora RDS"
  type        = string
  default     = "aurora-postgresql15"
}
variable "rds_instance_engine" {
  description = "Engine for standard RDS instance"
  type        = string
  default     = "postgres"
}
variable "rds_instance_engine_version" {
  description = "Engine version for standard RDS instance"
  type        = string
  default     = "17.2"
}
variable "rds_instance_parameter_group_family" {
  description = "Parameter group family for standard RDS instance"
  type        = string
  default     = "postgres17"
}

variable "name" {
  description = "Name"
  type        = string
  default     = "avoo"
}
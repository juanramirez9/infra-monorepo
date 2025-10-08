variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "secrets_manager_secret_name" {
  description = "Name of the Secrets Manager secret"
  type        = string
}

variable "enable_s3_versioning" {
  description = "Enable versioning for S3 bucket"
  type        = bool
  default     = true
}

variable "enable_s3_encryption" {
  description = "Enable encryption for S3 bucket"
  type        = bool
  default     = true
}

variable "secret_description" {
  description = "Description for the Secrets Manager secret"
  type        = string
  default     = "Secret managed by OpenTofu"
}
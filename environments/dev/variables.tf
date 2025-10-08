variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-project"
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
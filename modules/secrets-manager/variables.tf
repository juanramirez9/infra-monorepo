variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod) test 3"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "secret_description" {
  description = "Description of the secret"
  type        = string
  default     = "Secret managed by OpenTofu"
}

variable "secret_value" {
  description = "The secret value to store (optional, can be set manually)"
  type        = string
  default     = null
  sensitive   = true
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "ARN or Id of the AWS KMS key to be used to encrypt the secret values"
  type        = string
  default     = null
}

variable "replica_regions" {
  description = "List of regions to replicate the secret"
  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))
  default = []
}

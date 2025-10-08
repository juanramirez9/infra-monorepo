# S3 Bucket Outputs
output "dev_s3_bucket_id" {
  description = "The ID of the development S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "dev_s3_bucket_arn" {
  description = "The ARN of the development S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "dev_s3_bucket_domain_name" {
  description = "The domain name of the development S3 bucket"
  value       = module.s3_bucket.bucket_domain_name
}

# Secrets Manager Outputs
output "dev_secrets_manager_secret_id" {
  description = "The ID of the development Secrets Manager secret"
  value       = module.secrets_manager.secret_id
}

output "dev_secrets_manager_secret_arn" {
  description = "The ARN of the development Secrets Manager secret"
  value       = module.secrets_manager.secret_arn
  sensitive   = true
}

output "dev_secrets_manager_secret_name" {
  description = "The name of the development Secrets Manager secret"
  value       = module.secrets_manager.secret_name
}
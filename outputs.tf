# S3 Bucket Outputs
output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "s3_bucket_domain_name" {
  description = "The bucket domain name"
  value       = module.s3_bucket.bucket_domain_name
}

# Secrets Manager Outputs
output "secrets_manager_secret_id" {
  description = "The ID of the Secrets Manager secret"
  value       = module.secrets_manager.secret_id
}

output "secrets_manager_secret_arn" {
  description = "The ARN of the Secrets Manager secret"
  value       = module.secrets_manager.secret_arn
}

output "secrets_manager_secret_name" {
  description = "The name of the Secrets Manager secret"
  value       = module.secrets_manager.secret_name
}
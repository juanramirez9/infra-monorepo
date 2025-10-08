# S3 Bucket Outputs
output "prod_s3_bucket_id" {
  description = "The ID of the production S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "prod_s3_bucket_arn" {
  description = "The ARN of the production S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "prod_s3_bucket_domain_name" {
  description = "The domain name of the production S3 bucket"
  value       = module.s3_bucket.bucket_domain_name
}

# Secrets Manager Outputs
output "prod_secrets_manager_secret_id" {
  description = "The ID of the production Secrets Manager secret"
  value       = module.secrets_manager.secret_id
}

output "prod_secrets_manager_secret_arn" {
  description = "The ARN of the production Secrets Manager secret"
  value       = module.secrets_manager.secret_arn
  sensitive   = true
}

output "prod_secrets_manager_secret_name" {
  description = "The name of the production Secrets Manager secret"
  value       = module.secrets_manager.secret_name
}
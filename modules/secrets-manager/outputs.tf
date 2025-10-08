output "secret_id" {
  description = "The ID of the secret"
  value       = aws_secretsmanager_secret.this.id
}

output "secret_arn" {
  description = "The ARN of the secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "The name of the secret"
  value       = aws_secretsmanager_secret.this.name
}

output "secret_version_id" {
  description = "The unique identifier of the version of the secret"
  value       = var.secret_value != null ? aws_secretsmanager_secret_version.this[0].version_id : null
}

output "secret_kms_key_id" {
  description = "The ARN or alias of the AWS KMS customer master key (CMK) that's used to encrypt the secret"
  value       = aws_secretsmanager_secret.this.kms_key_id
}
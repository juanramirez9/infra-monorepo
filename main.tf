# S3 Bucket Module
module "s3_bucket" {
  source = "./modules/s3-bucket"
  
  bucket_name         = var.s3_bucket_name
  environment         = var.environment
  project_name        = var.project_name
  enable_versioning   = var.enable_s3_versioning
  enable_encryption   = var.enable_s3_encryption
}

# Secrets Manager Module
module "secrets_manager" {
  source = "./modules/secrets-manager"
  
  secret_name        = var.secrets_manager_secret_name
  environment        = var.environment
  project_name       = var.project_name
  secret_description = var.secret_description
}
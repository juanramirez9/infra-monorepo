terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment and configure for remote state storage
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "prod/terraform.tfstate"
  #   region = "us-west-2"
  # }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "OpenTofu"
    }
  }
}

# S3 Bucket Module
module "s3_bucket" {
  source = "../../modules/s3-bucket"
  
  bucket_name         = "${var.project_name}-${var.environment}-bucket"
  environment         = var.environment
  project_name        = var.project_name
  enable_versioning   = var.enable_s3_versioning
  enable_encryption   = var.enable_s3_encryption
  force_destroy       = false  # Protect production data
}

# Secrets Manager Module
module "secrets_manager" {
  source = "../../modules/secrets-manager"
  
  secret_name                = "${var.project_name}-${var.environment}-secret"
  environment                = var.environment
  project_name               = var.project_name
  secret_description         = "Production environment secret for ${var.project_name}"
  recovery_window_in_days    = 30  # Longer recovery window for production
}
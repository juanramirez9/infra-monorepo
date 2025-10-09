# Infrastructure Monorepo

This repository contains infrastructure as code using OpenTofu (Terraform) with a modular approach. The infrastructure is organized into reusable modules and environment-specific configurations.

## Repository Structure

```
infra-modules-monorepo/
├── modules/                    # Reusable infrastructure modules
│   ├── s3-bucket/             # S3 bucket module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── secrets-manager/       # AWS Secrets Manager module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/              # Environment-specific configurations
│   ├── dev/                   # Development environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars.example
│   └── prod/                  # Production environment
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars.example
├── main.tf                    # Root configuration (optional)
├── variables.tf               # Root variables
├── outputs.tf                 # Root outputs
├── versions.tf                # Provider versions
├── .gitignore                 # Git ignore rules
└── README.md                  # This file
```

## Modules

### S3 Bucket Module (`modules/s3-bucket/`)

Creates an S3 bucket with the following features:
- Configurable versioning
- Server-side encryption (AES256)
- Public access blocking
- Lifecycle configuration for cost optimization
- Proper tagging

**Inputs:**
- `bucket_name` - Name of the S3 bucket
- `environment` - Environment name (dev, staging, prod)
- `project_name` - Name of the project
- `enable_versioning` - Enable versioning (default: true)
- `enable_encryption` - Enable encryption (default: true)
- `force_destroy` - Force destroy bucket even with objects (default: false)

**Outputs:**
- `bucket_id` - The ID of the S3 bucket
- `bucket_arn` - The ARN of the S3 bucket
- `bucket_domain_name` - The bucket domain name

### Secrets Manager Module (`modules/secrets-manager/`)

Creates an AWS Secrets Manager secret with the following features:
- Configurable recovery window
- Optional KMS encryption
- Multi-region replication support
- IAM policy for secure access
- Proper tagging

**Inputs:**
- `secret_name` - Name of the secret
- `environment` - Environment name (dev, staging, prod)
- `project_name` - Name of the project
- `secret_description` - Description of the secret
- `secret_value` - Optional secret value (sensitive)
- `recovery_window_in_days` - Recovery window (default: 30)

**Outputs:**
- `secret_id` - The ID of the secret
- `secret_arn` - The ARN of the secret
- `secret_name` - The name of the secret

## Getting Started

### Prerequisites

1. Install [OpenTofu](https://opentofu.org/) or [Terraform](https://www.terraform.io/)
2. Configure AWS credentials:
   ```bash
   aws configure
   ```
   Or set environment variables:
   ```bash
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   export AWS_DEFAULT_REGION="us-west-2"
   ```

### Deploy to Development Environment

1. Navigate to the development environment:
   ```bash
   cd environments/dev
   ```

2. Copy and customize the variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edit `terraform.tfvars` with your specific values:
   ```hcl
   aws_region    = "us-west-2"
   environment   = "dev"
   project_name  = "your-project-name"
   
   enable_s3_versioning  = true
   enable_s3_encryption  = true
   ```

4. Initialize OpenTofu:
   ```bash
   tofu init
   ```

5. Plan the deployment:
   ```bash
   tofu plan
   ```

6. Apply the configuration:
   ```bash
   tofu apply
   ```

### Deploy to Production Environment

1. Navigate to the production environment:
   ```bash
   cd environments/prod
   ```

2. Follow the same steps as development, but customize the `terraform.tfvars` file for production settings.

### Using Individual Modules

You can also use the modules individually in your own configurations:

```hcl
module "my_s3_bucket" {
  source = "./modules/s3-bucket"
  
  bucket_name       = "my-unique-bucket-name"
  environment       = "dev"
  project_name      = "my-project"
  enable_versioning = true
  enable_encryption = true
}

module "my_secret" {
  source = "./modules/secrets-manager"
  
  secret_name        = "my-app-secret"
  environment        = "dev"
  project_name       = "my-project"
  secret_description = "My application secret"
}
```

## Best Practices

1. **State Management**: Configure remote state storage (S3 + DynamoDB) for production environments
2. **Variable Files**: Never commit `*.tfvars` files containing sensitive data
3. **Naming Convention**: Use consistent naming patterns across environments
4. **Tagging**: All resources are automatically tagged with Project, Environment, and ManagedBy tags
5. **Security**: Enable encryption and proper access controls by default

## Remote State Configuration

For production environments, configure remote state storage by uncommenting and configuring the backend in each environment's `main.tf`:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "prod/terraform.tfstate"
    region = "us-west-2"
    # Optional: DynamoDB table for state locking
    # dynamodb_table = "terraform-state-lock"
  }
}
```

## CI/CD Pipeline

This repository includes a comprehensive CI/CD pipeline using GitHub Actions with the following features:

### Automated Testing
- **Format Check**: Validates Terraform/OpenTofu code formatting
- **Validation**: Runs `tofu validate` on all modules and environments
- **Security Scanning**: Uses Trivy to scan for security vulnerabilities
- **Plan Testing**: Runs `tofu plan` on pull requests for validation

### Semantic Release
This project uses [semantic-release](https://semantic-release.gitbook.io/) for automated versioning and releases based on commit messages.

#### Commit Message Format
Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat:` A new feature (triggers minor release)
- `fix:` A bug fix (triggers patch release)
- `docs:` Documentation changes (triggers patch release)
- `refactor:` Code refactoring (triggers patch release)
- `perf:` Performance improvements (triggers patch release)
- `build:` Build system changes (triggers patch release)
- `ci:` CI configuration changes (no release)
- `test:` Adding tests (no release)
- `chore:` Maintenance tasks (no release)

**Breaking Changes:**
- Add `BREAKING CHANGE:` in the footer or `!` after type (triggers major release)

#### Examples:
```bash
feat(s3): add lifecycle configuration for cost optimization
fix(secrets): resolve IAM policy attachment issue
docs: update deployment instructions
feat!: change module interface (breaking change)
```

### Deployment Workflow
1. **Pull Request**: Runs validation and security scans
2. **Merge to main**: Triggers semantic release
3. **New Release**: Automatically deploys to dev environment
4. **Production**: Manual approval required for production deployment

### Required Secrets and Variables

Configure these in your GitHub repository settings:

**Secrets:**
- `AWS_ACCESS_KEY_ID`: AWS access key for dev environment
- `AWS_SECRET_ACCESS_KEY`: AWS secret key for dev environment
- `PROD_AWS_ACCESS_KEY_ID`: AWS access key for production
- `PROD_AWS_SECRET_ACCESS_KEY`: AWS secret key for production

**Variables:**
- `PROJECT_NAME`: Your project name (used in resource naming)

### Environment Protection Rules
- **Development**: Automatic deployment after release
- **Production**: Requires manual approval and uses separate AWS credentials

## Contributing

### Development Workflow
1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feat/amazing-feature`
3. **Follow** our coding standards and commit conventions
4. **Test** your changes locally:
   ```bash
   npm run format      # Format Terraform code
   npm run validate    # Validate configurations
   npm run security    # Run security scans
   ```
5. **Commit** using conventional commit format
6. **Push** to your fork and **create** a Pull Request

### Code Standards
1. **Terraform Formatting**: All `.tf` files must be formatted with `terraform fmt`
2. **Documentation**: Update relevant documentation for any changes
3. **Security**: Follow security best practices (encryption, least privilege, etc.)
4. **Testing**: Ensure all validations pass before submitting PR
5. **Commit Messages**: Use conventional commit format for semantic versioning

### Local Development Setup
```bash
# Install dependencies
npm install

# Format all Terraform files
npm run format

# Validate all configurations
npm run validate

# Run security scan
npm run security
```

### Module Development Guidelines
1. **Variables**: Always include descriptions and appropriate types
2. **Outputs**: Expose all relevant resource attributes
3. **Tagging**: Ensure consistent tagging across all resources
4. **Documentation**: Update module documentation in README
5. **Versioning**: Use semantic versioning for module releases

## License

This project is licensed under the MIT License - see the LICENSE file for details.
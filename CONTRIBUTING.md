# Contributing to Infrastructure Monorepo

Thank you for your interest in contributing to this infrastructure project! This document provides guidelines and information for contributors.

## Code of Conduct

Please be respectful and constructive in all interactions. We aim to create a welcoming environment for all contributors.

## Development Process

### 1. Setting Up Your Development Environment

```bash
# Clone the repository
git clone https://github.com/juanramirez9/infra-modules-monorepo.git
cd infra-modules-monorepo

# Install dependencies
npm install

# Install OpenTofu/Terraform
# Follow installation instructions at https://opentofu.org/
```

### 2. Making Changes

1. **Create a feature branch**:
   ```bash
   git checkout -b feat/your-feature-name
   ```

2. **Make your changes** following our coding standards

3. **Test your changes**:
   ```bash
   # Format code
   npm run format
   
   # Validate configurations
   npm run validate
   
   # Run security scan
   npm run security
   ```

4. **Commit using conventional commits**:
   ```bash
   git add .
   git commit -m "feat(module): add new functionality"
   ```

5. **Push and create a Pull Request**:
   ```bash
   git push origin feat/your-feature-name
   ```

## Commit Message Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org/) for automated versioning:

### Format
```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types
- `feat`: New feature (minor version bump)
- `fix`: Bug fix (patch version bump)
- `docs`: Documentation changes (patch version bump)
- `refactor`: Code refactoring (patch version bump)
- `perf`: Performance improvements (patch version bump)
- `build`: Build system changes (patch version bump)
- `ci`: CI configuration changes (no version bump)
- `test`: Adding tests (no version bump)
- `chore`: Maintenance tasks (no version bump)
- `revert`: Reverting changes (patch version bump)

### Breaking Changes
Add `BREAKING CHANGE:` in the footer or `!` after the type for major version bumps.

### Examples
```bash
feat(s3): add bucket lifecycle configuration
fix(secrets): resolve IAM policy attachment
docs: update module usage examples
feat!: change module interface (breaking change)
BREAKING CHANGE: remove deprecated variable
```

## Coding Standards

### Terraform/OpenTofu Code
1. **Formatting**: Use `terraform fmt` for consistent formatting
2. **Naming**: Use descriptive names for resources and variables
3. **Documentation**: Include descriptions for all variables and outputs
4. **Security**: Follow AWS security best practices
5. **Modularity**: Keep modules focused and reusable

### File Structure
```
modules/
├── module-name/
│   ├── main.tf          # Main resources
│   ├── variables.tf     # Input variables
│   ├── outputs.tf       # Output values
│   └── README.md        # Module documentation
```

### Variable Guidelines
```hcl
variable "example_var" {
  description = "Clear description of the variable's purpose"
  type        = string
  default     = "default-value"
  
  validation {
    condition     = length(var.example_var) > 0
    error_message = "Variable cannot be empty."
  }
}
```

### Output Guidelines
```hcl
output "example_output" {
  description = "Description of what this output represents"
  value       = aws_resource.example.attribute
  sensitive   = false  # Set to true for sensitive data
}
```

## Testing

### Local Testing
```bash
# Format all files
npm run format

# Validate syntax
npm run validate

# Security scan
npm run security

# Manual testing
cd environments/dev
tofu init
tofu plan -var="project_name=test"
```

### CI/CD Testing
- All pull requests run automated tests
- Format checking, validation, and security scanning
- Test plans are generated for review

## Pull Request Process

1. **Fork** the repository
2. **Create** a feature branch from `main`
3. **Make** your changes following our guidelines
4. **Test** your changes locally
5. **Submit** a pull request with:
   - Clear title using conventional commit format
   - Detailed description of changes
   - Reference to any related issues
   - Screenshots (if applicable)

### Pull Request Checklist
- [ ] Code follows our formatting standards
- [ ] All validation checks pass
- [ ] Security scan passes
- [ ] Documentation is updated
- [ ] Commit messages follow conventional format
- [ ] No sensitive information is exposed

## Release Process

Releases are automated using semantic-release:

1. **Merge** to main branch triggers release workflow
2. **Semantic-release** analyzes commits and determines version
3. **GitHub release** is created with changelog
4. **Deployment** to development environment is automatic
5. **Production deployment** requires manual approval

## Getting Help

- **Issues**: Create a GitHub issue for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Check the README.md for detailed information

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes (for significant contributions)
- Project documentation

Thank you for contributing to making infrastructure management better! 🚀
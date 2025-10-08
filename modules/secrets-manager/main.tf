# Secrets Manager Secret
resource "aws_secretsmanager_secret" "this" {
  name                    = var.secret_name
  description             = var.secret_description
  recovery_window_in_days = var.recovery_window_in_days
  kms_key_id              = var.kms_key_id

  dynamic "replica" {
    for_each = var.replica_regions
    content {
      region     = replica.value.region
      kms_key_id = replica.value.kms_key_id
    }
  }

  tags = {
    Name        = var.secret_name
    Environment = var.environment
    Project     = var.project_name
  }
}

# Secrets Manager Secret Version (only if secret_value is provided)
resource "aws_secretsmanager_secret_version" "this" {
  count          = var.secret_value != null ? 1 : 0
  secret_id      = aws_secretsmanager_secret.this.id
  secret_string  = var.secret_value
}

# IAM Policy for accessing the secret
data "aws_iam_policy_document" "secret_policy" {
  statement {
    sid    = "EnableIAMUserPermissions"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions   = ["secretsmanager:*"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowSecretsManagerAccess"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["secretsmanager.amazonaws.com"]
    }

    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecret"
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "secretsmanager:ResourceTag/Environment"
      values   = [var.environment]
    }
  }
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Resource policy for the secret
resource "aws_secretsmanager_secret_policy" "this" {
  secret_arn = aws_secretsmanager_secret.this.arn
  policy     = data.aws_iam_policy_document.secret_policy.json
}
# ==============================================================================
# variables.tf : Input Variables Definition
# ==============================================================================
# Variables make Terraform configurations modular, reusable, and customizable
# across different environments (dev, staging, prod).

# 1. String variable with default value and custom validation
variable "environment" {
  description = "Target deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  # Custom validation rule
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment variable must be one of: dev, staging, prod."
  }
}

# 2. String variable for naming prefixes
variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
  default     = "my-terraform-app"
}

# 3. Numeric variable (demonstrating count/loops)
variable "file_count" {
  description = "Number of mock worker node files to generate"
  type        = number
  default     = 2
}

# 4. List variable (ordered collection of strings)
variable "allowed_roles" {
  description = "List of system roles permitted to access the application"
  type        = list(string)
  default     = ["developer", "devops", "auditor"]
}

# 5. Map variable (Key-Value pairs)
variable "common_tags" {
  description = "Common baseline tags applied to resources"
  type        = map(string)
  default = {
    Owner     = "DevOps-Team"
    ManagedBy = "Terraform"
  }
}

# 6. Sensitive variable (masked in CLI outputs and logs)
variable "database_password" {
  description = "Database administrator password (marked sensitive)"
  type        = string
  default     = "SuperSecretP@ssw0rd!"
  sensitive   = true # Prevents value from displaying in 'terraform plan' and 'terraform apply' console outputs
}

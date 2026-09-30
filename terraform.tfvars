# ==============================================================================
# terraform.tfvars : Variable Values Definition
# ==============================================================================
# Precedence order for Terraform variables (lowest to highest):
# 1. Default value in variables.tf
# 2. Environment variables (TF_VAR_*)
# 3. terraform.tfvars or *.auto.tfvars (this file)
# 4. CLI flags: -var or -var-file

environment  = "dev"
project_name = "demo-learning-terraform"
file_count   = 2

allowed_roles = [
  "admin",
  "developer",
  "qa-tester"
]

common_tags = {
  Owner      = "DevOps-Engineer"
  Department = "Cloud-Platform"
  CostCenter = "TH-101"
}

# For sensitive production credentials, supply them via environment variables
# (TF_VAR_database_password) or secret managers rather than committing to Git.
database_password = "ChangeMeSecurely1234!"

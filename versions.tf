# ==============================================================================
# versions.tf : Terraform Engine & Provider Version Constraints
# ==============================================================================
# Purpose:
# 1. Enforces consistent Terraform CLI version across team members and CI/CD.
# 2. Locks provider versions to prevent unexpected breaking changes.

terraform {
  # Minimum required version of the Terraform CLI binary
  required_version = ">= 1.5.0"

  # Required providers (plugins used to interact with cloud/local APIs)
  required_providers {
    # 1. Local Provider: Manage local files (great for testing without cloud credentials)
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }

    # 2. Random Provider: Generates random values (IDs, pet names, passwords)
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }

    # 3. AWS Provider (Example for real cloud infrastructure - commented for local tests)
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 5.0"
    # }
  }

  # Remote Backend: Used to store state remotely for team collaboration (e.g., S3, Terraform Cloud)
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "dev/terraform.tfstate"
  #   region         = "ap-southeast-1"
  #   dynamodb_table = "terraform-lock-table" # Enables state locking to prevent race conditions
  # }
}

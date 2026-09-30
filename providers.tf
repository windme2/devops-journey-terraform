# ==============================================================================
# providers.tf : Provider Configurations
# ==============================================================================
# Providers act as plugins that communicate with target platform APIs
# (e.g., AWS, Azure, GCP, Docker, Kubernetes, or the local OS).

# 1. Local Provider Configuration (No additional configuration required)
provider "local" {
  # Default configuration
}

# 2. Random Provider Configuration (No additional configuration required)
provider "random" {
  # Default configuration
}

# 3. AWS Provider Configuration Example (Commented out for local testing)
# provider "aws" {
#   region = "ap-southeast-1" # Singapore region (Asia Pacific)
#
#   # Automatically apply standard tags to all resources managed by this provider
#   default_tags {
#     tags = {
#       Environment = "development"
#       ManagedBy   = "Terraform"
#       Project     = "LearningTerraform"
#     }
#   }
# }

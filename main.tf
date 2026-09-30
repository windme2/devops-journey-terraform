# ==============================================================================
# main.tf : Main Infrastructure Resources and Data Sources
# ==============================================================================
# Syntax structure:
# resource "<PROVIDER>_<TYPE>" "<LOCAL_NAME>" {
#   attribute1 = value1
#   attribute2 = value2
# }

# ------------------------------------------------------------------------------
# 1. Local Values (Internal computed values, not exposed as external inputs)
# ------------------------------------------------------------------------------
locals {
  # Standardized prefix for naming convention
  name_prefix = "${var.project_name}-${var.environment}"

  # Merge variable tags with dynamically computed tags
  merged_tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      CreatedAt   = timestamp()
    }
  )
}

# ------------------------------------------------------------------------------
# 2. Resource 1: Generate unique random pet name string
# ------------------------------------------------------------------------------
resource "random_pet" "server_name" {
  length    = 2
  separator = "-"
}

# ------------------------------------------------------------------------------
# 3. Resource 2: Generate random 16-character secure password
# ------------------------------------------------------------------------------
resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# ------------------------------------------------------------------------------
# 4. Resource 3: Generate application configuration file on local machine
# ------------------------------------------------------------------------------
# Demonstrates implicit dependency:
# Terraform automatically waits for random_pet and random_password to resolve
# before generating this file.
resource "local_file" "config_file" {
  filename = "${path.module}/output_config.json"

  # Use jsonencode function to create properly formatted JSON
  content = jsonencode({
    application_name = local.name_prefix
    server_hostname  = "${local.name_prefix}-${random_pet.server_name.id}.internal"
    environment      = var.environment
    roles            = var.allowed_roles
    tags             = local.merged_tags
    system_status    = "ACTIVE"
  })

  file_permission = "0644"
}

# ------------------------------------------------------------------------------
# 5. Resource 4: Using "count" to loop and create multiple resource instances
# ------------------------------------------------------------------------------
resource "local_file" "worker_nodes" {
  count = var.file_count

  # count.index is zero-based (0, 1, 2, ...)
  filename = "${path.module}/worker_${count.index + 1}.txt"

  content = <<-EOT
    ========================================
    Worker Node #${count.index + 1}
    ========================================
    Cluster: ${local.name_prefix}
    Node ID: node-${count.index + 1}
    Generated at: ${timestamp()}
  EOT
}

# ------------------------------------------------------------------------------
# 6. Data Source: Read existing resources or external data (Read-Only)
# ------------------------------------------------------------------------------
# Difference:
# - resource: manages lifecycle (Create, Read, Update, Delete)
# - data: queries existing state (Read-Only)
data "local_file" "read_config" {
  filename = local_file.config_file.filename

  # Explicit dependency using depends_on
  depends_on = [local_file.config_file]
}

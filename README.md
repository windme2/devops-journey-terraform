# 📘 Terraform Fundamentals & Starter Template

> 🎯 **DevOps Journey Checkpoint**:
> _"The very first step of learning Terraform and Infrastructure as Code (IaC) — saved as a milestone for my future self to look back on as a DevOps Engineer."_ 🚀

---

## 📑 Table of Contents

1. [What is Terraform?](#1-what-is-terraform)
2. [Standard Project Structure](#2-standard-project-structure)
3. [Terraform Core Lifecycle & Commands](#3-terraform-core-lifecycle--commands)
4. [Key Concepts & Syntax](#4-key-concepts--syntax)
5. [Understanding Terraform State](#5-understanding-terraform-state)
6. [Hands-on Quickstart Guide](#6-hands-on-quickstart-guide)

---

## 1. What is Terraform?

**Terraform** is an open-source **Infrastructure as Code (IaC)** software tool created by HashiCorp. It enables users to define and provision cloud and on-premises infrastructure resources using a declarative configuration language known as **HCL (HashiCorp Configuration Language)**.

### Key Advantages:

- **Declarative**: Define _what_ the desired target infrastructure looks like, not _how_ to step-by-step assemble it.
- **Multi-Cloud**: Unified workflow to manage AWS, Azure, GCP, Kubernetes, Cloudflare, and local resources.
- **State Management**: Tracks current infrastructure in `terraform.tfstate`, enabling accurate delta calculations before applying modifications.

---

## 2. Standard Project Structure

Following production-grade conventions, Terraform projects are modularized into standard files:

| File                         | Purpose                                                                                        |
| :--------------------------- | :--------------------------------------------------------------------------------------------- |
| **`versions.tf`**            | Declares minimum Terraform CLI version and required provider plugins with version constraints. |
| **`providers.tf`**           | Configures cloud/service providers (e.g., regions, default tags, credentials).                 |
| **`variables.tf`**           | Declares reusable input variables (types, defaults, descriptions, and validations).            |
| **`terraform.tfvars`**       | Assigns concrete values to input variables (similar to environment variable definition).       |
| **`main.tf`**                | Defines core resources, data sources, and internal local computed values (`locals`).           |
| **`outputs.tf`**             | Exposes output attributes (hostnames, file paths, IDs) after execution.                        |
| **`.gitignore`**             | Excludes sensitive and binary files (e.g., `.terraform/`, `*.tfstate`).                        |
| **`aws_example.tf.example`** | Reference blueprint demonstrating real AWS infrastructure (EC2, S3, Security Group).           |
| **`README_TH.md`**           | Complete Thai reference guide for in-depth conceptual learning.                                |

---

## 3. Terraform Core Lifecycle & Commands

```text
[ Write Code ]
      │
      ▼
terraform init     ──► Downloads provider plugins and initializes the backend
      │
      ▼
terraform plan     ──► Generates a dry-run execution plan (Create / Update / Destroy)
      │
      ▼
terraform apply    ──► Executes changes against target infrastructure
      │
      ▼
terraform destroy  ──► Tears down and cleans up all managed resources
```

### Essential CLI Commands:

- `terraform fmt` : Automatically formats HCL code according to official style guidelines.
- `terraform validate` : Verifies syntactic and semantic correctness of configurations.
- `terraform init` : Initializes workspace and installs provider dependencies.
- `terraform plan` : Computes dry-run execution preview.
- `terraform apply` : Applies declared infrastructure changes.
- `terraform output` : Queries output values from state.
- `terraform destroy` : Destroys all managed infrastructure objects.

---

## 4. Key Concepts & Syntax

### 4.1 Resource Block (Provisioning)

```hcl
resource "local_file" "example" {
  filename = "example.txt"
  content  = "Hello, Terraform!"
}
```

### 4.2 Data Source (Querying existing resources)

```hcl
data "local_file" "existing" {
  filename = "example.txt"
}
```

### 4.3 Variables vs. Locals

- **`var.<name>`**: External inputs configurable per environment (via `.tfvars` or CLI).
- **`local.<name>`**: Internal intermediate values calculated inside HCL code.

---

## 5. Understanding Terraform State

When running `terraform apply`, Terraform generates **`terraform.tfstate`**:

- Acts as the single source of truth mapping your code definitions to real-world resources.
- ⚠️ **Security Warning**: May contain unencrypted sensitive values (e.g., passwords, keys). **Never commit state files to public Git repositories.**
- In enterprise teams, use a **Remote Backend** (such as AWS S3 with DynamoDB state locking) instead of local files.

---

## 6. Hands-on Quickstart Guide

This repository is ready to execute out-of-the-box using built-in `local` and `random` providers:

### Step 1: Format and Validate

```bash
terraform fmt
terraform validate
```

### Step 2: Initialize Provider Plugins

```bash
terraform init
```

### Step 3: Review Execution Plan

```bash
terraform plan
```

### Step 4: Apply and Provision

```bash
terraform apply
```

_(Enter `yes` when prompted)_

### Step 5: Inspect Outputs

```bash
terraform output

# View masked sensitive output
terraform output -raw generated_admin_password
echo ""
```

### Step 6: Clean Up

```bash
terraform destroy
```

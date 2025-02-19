# Infrastructure Setup using Terraform

## Prerequisites
Before you begin, ensure you have the following installed on your system:

1. **Terraform**: [Download Terraform](https://developer.hashicorp.com/terraform/downloads)
2. **AWS CLI (if deploying on AWS)**: [Download AWS CLI](https://aws.amazon.com/cli/)
3. **Git (for version control)**: [Download Git](https://git-scm.com/downloads)
4. **Text Editor (e.g., VS Code)**: [Download VS Code](https://code.visualstudio.com/)

## Steps to Set Up Terraform Infrastructure

### 1. Configure AWS Credentials (For AWS Deployments)
If using AWS, configure your credentials by running:
```sh
aws configure
```
Enter the following details when prompted:
- **AWS Access Key ID**
- **AWS Secret Access Key**
- **Default region name** (e.g., `us-east-1`)
- **Default output format** (leave blank for JSON)

### 2. Initialize Terraform
Initialize Terraform in your working directory:
```sh
terraform init
```

### 3. Validate Terraform Configuration
To ensure your configuration is correct, run:
```sh
terraform validate
```

### 4. Format and Check Terraform Code
To format Terraform files recursively:
```sh
terraform fmt -recursive
```
To check if files are correctly formatted without changing them:
```sh
terraform fmt -check -recursive
```

### 5. Generate and Review the Execution Plan
Run the following command to generate a plan showing what Terraform will create, update, or destroy:
```sh
terraform plan
```

### 6. Apply the Terraform Configuration
Apply the changes to provision the infrastructure:
```sh
terraform apply
```
Type `yes` when prompted to confirm.

### 7. Destroy the Infrastructure (When Needed)
To remove all resources created by Terraform:
```sh
terraform destroy
```
Type `yes` when prompted to confirm.

---
### Notes:
- Always review the `terraform plan` output before applying changes.
- Keep your Terraform state file (`terraform.tfstate`) secure.
- 

Infrastructure Setup using Terraform

Before you begin, ensure you have the following installed on your system:

Terraform: Download Terraform

AWS CLI (if deploying on AWS): Download AWS CLI

Git (for version control): Download Git

Text Editor (VS Code)

Step 1: Configure AWS Credentials (For AWS Deployments)

If using AWS, configure your credentials:

aws configure

Enter the following details:

AWS Access Key ID

AWS Secret Access Key

Default region name (e.g., us-east-1)

Default output format (leave blank for JSON)

Step 2: Initialize Terraform

terraform init

Step 3: Validate Terraform Configuration

To ensure your configuration is correct, run:

terraform validate

Step 4: Format and Check Terraform Code

terraform fmt -recursive

To check if files are correctly formatted without changing them:

terraform fmt -check -recursive

Step 5: Generate and Review the Execution Plan

Run the following command to generate a plan showing what Terraform will create, update, or destroy:

terraform plan

Step 6: Apply the Terraform Configuration

terraform apply

Type yes when prompted to confirm.

Step 7: Verify the Deployment

 check the AWS Console.


Step 9: Destroy the Infrastructure

terraform destroy

Type yes when prompted to confirm.
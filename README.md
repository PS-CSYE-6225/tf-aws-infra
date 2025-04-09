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


## SSL Certificate Configuration

To secure our application endpoints using HTTPS, SSL certificates are configured for both environments:

---

### Development Environment (dev)

We use **AWS Certificate Manager (ACM)** to request and manage a certificate for the `dev` environment.

#### Steps:

1. **Navigate to AWS ACM Console**
   - URL: [https://console.aws.amazon.com/acm/home?region=us-east-1](https://console.aws.amazon.com/acm/home?region=us-east-1)

2. **Request a Public Certificate**
   - Choose "Request a public certificate"
   - Enter domain: `dev.<yourdomain>.com`
   - Validation: Select **DNS validation**
   - AWS provides a DNS CNAME record; add it in your Route 53 hosted zone.

3. **Wait for Validation**
   - Certificate will move to "Issued" status upon DNS propagation.

4. **Locate the ARN**
   - Copy the ARN of the certificate once issued (you will use this in Terraform):
     ```
     arn:aws:acm:us-east-1:<account_id>:certificate/<certificate-id>
     ```

5. **Set Variable in Terraform**
   In your `terraform.tfvars` or environment-specific variable file:
   ```hcl
   dev_certificate_arn = "arn:aws:acm:us-east-1:xxx:certificate/abc123"

For the demo environment, AWS ACM cannot be used. We must import an SSL certificate from an external provider.

🔐 Free Certificate via ZeroSSL
Go to: https://zerossl.com

Create a Free 90-Day Certificate

Use domain: demo.<yourdomain>.com

Choose DNS Validation

Add CNAME record to your DNS provider (e.g., Namecheap)

Wait for validation

Download Certificates After issuing, download:

certificate.crt

ca_bundle.crt

private.key

📥 Import to AWS ACM via CLI
Ensure you're using the demo AWS profile:

bash
Copy
Edit
aws configure --profile demo
Then, import the certificate:

aws acm import-certificate \
  --certificate fileb://certificate.crt \
  --private-key fileb://private.key \
  --certificate-chain fileb://ca_bundle.crt \
  --region us-east-1 \
  --profile demo
Get Certificate ARN

aws acm list-certificates --profile demo
Copy the correct ARN and paste it into your terraform.tfvars:

demo_certificate_arn = "arn:aws:acm:us-east-1:xxxxxxxxxxxx:certificate/xyz-5678-
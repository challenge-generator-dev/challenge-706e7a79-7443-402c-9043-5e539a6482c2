# Terraform AWS Infrastructure

## Project Structure

```
.
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── database/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── messaging/
│       ├── main.tf
│       └── outputs.tf
├── versions.tf
├── providers.tf
└── README.md
```

## Prerequisites

1. **Terraform**: Install Terraform CLI (v1.5+ recommended)
   ```bash
   brew install terraform  # macOS
   choco install terraform # Windows
   ```

2. **AWS CLI**: Configure AWS credentials
   ```bash
   aws configure
   ```
   Ensure your IAM user has sufficient permissions to create the resources defined in the modules.

3. **AWS Provider**: This project uses AWS Provider v5.x

## Setup Instructions

### Initialize Terraform
```bash
cd environments/dev
terraform init
```

### Plan Infrastructure
```bash
terraform plan
```

### Apply Infrastructure
```bash
terraform apply
```

### Destroy Infrastructure
```bash
terraform destroy
```

## Modules Overview

### Networking
- VPC with CIDR block
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Route tables

### Compute
- EC2 instances
- Auto Scaling Groups
- Load Balancers
- Security Groups

### Database
- RDS instances
- DynamoDB tables
- ElastiCache clusters

### Messaging
- SQS queues
- SNS topics
- EventBridge rules

## Environment Configuration

Each environment (dev/prod) has its own:
- `main.tf`: Root module configuration
- `variables.tf`: Input variables
- `outputs.tf`: Output values
- `terraform.tfvars`: Environment-specific values (dev only)

## Validation

After applying, verify resources were created:
```bash
terraform output
aws ec2 describe-vpcs
aws rds describe-db-instances
```

## Best Practices

1. Never commit `terraform.tfvars` with sensitive data
2. Use remote state backend for team collaboration
3. Tag all resources for cost tracking
4. Review changes with `terraform plan` before applying
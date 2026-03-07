# AWS Infrastructure as Code — Terraform & CloudFormation

This project demonstrates the ability to provision AWS infrastructure using two different
Infrastructure as Code (IaC) approaches: **Terraform** and **CloudFormation**.
Both paths cover the same AWS concepts and resources, letting you compare the tools
and choose the one that fits your workflow.

---

## Approaches

### [Terraform](./terraform/)

Uses HashiCorp Terraform to define and manage AWS resources.
Sections are structured as Terraform modules that can be toggled on or off independently.

**Tooling required:** Terraform >= 1.5.0, AWS credentials

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
make init && make plan && make apply
```

### [CloudFormation](./cloudformation/)

Uses AWS CloudFormation to define and manage AWS resources via YAML/JSON templates.
Each section is a standalone CloudFormation stack that can be deployed independently.

**Tooling required:** AWS CLI, AWS credentials

```bash
cd cloudformation
# deploy a stack
aws cloudformation deploy --template-file <template>.yaml --stack-name <stack-name>
```

---

## Sections Covered

| Section | Description |
|---|---|
| 01 — Budgets | Monthly cost budget with email alerts |
| 02 — EC2 | Free-tier EC2 instance with SSH access |
| 03 — S3 + CloudFront | Static website hosted on S3, served via CloudFront |
| 04 — API Gateway | HTTP API Gateway with CORS (requires section 03) |
| 05 — Roulette | Roulette/raffle app with DynamoDB + Lambda (requires sections 03 & 04) |

---

## Repository Layout

```
.
├── terraform/          # Terraform modules
│   ├── section-01-budgets/
│   ├── section-02-ec2/
│   ├── section-03-s3-cloudfront/
│   ├── section-04-api-gateway/
│   └── section-05-roulette/
└── cloudformation/     # CloudFormation templates (coming soon)
    ├── section-01-budgets/
    └── section-02-ec2/
```

---

## Prerequisites

- An AWS account (free tier eligible for the first 12 months)
- AWS credentials configured locally (`aws configure` or environment variables)
- The CLI tool for your chosen approach (Terraform or AWS CLI)

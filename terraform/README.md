# AWS Free Tier with Terraform — Tutorial

A step-by-step tutorial on using the **AWS Free Tier** with Terraform locally.
Each section is a Terraform module that can be toggled on or off via the `enabled_sections` variable.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- AWS credentials configured locally (`aws configure` or environment variables)
- An AWS account (free tier eligible for the first 12 months)

---

## Quick Start

```bash
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with your values and choose which sections to enable

make init
make plan
make apply
```

To tear down all resources:

```bash
make destroy
```

---

## Enabling / Disabling Sections

All sections are controlled from the root `terraform.tfvars` via the `enabled_sections` variable.
Set a section to `true` to deploy it, or `false` to skip it:

```hcl
enabled_sections = {
  section01 = true   # Budgets
  section02 = false  # EC2
  section03 = false  # S3 + CloudFront static website
  section04 = false  # API Gateway (requires section03)
  section05 = false  # Roulette app — DynamoDB + Lambda (requires section03 & section04)
}
```

---

## Sections

| Section | Module | Description |
|---|---|---|
| 01 | [section-01-budgets](./section-01-budgets/README.md) | Monthly cost budget with email alerts |
| 02 | [section-02-ec2](./section-02-ec2/README.md) | Free-tier EC2 instance with SSH access |
| 03 | [section-03-s3-cloudfront](./section-03-s3-cloudfront/README.md) | Static website on S3 + CloudFront |
| 04 | [section-04-api-gateway](./section-04-api-gateway/README.md) | HTTP API Gateway — CORS origin sourced from section 03 |
| 05 | [section-05-roulette](./section-05-roulette/README.md) | Roulette/raffle app — DynamoDB, Lambda, routes on section 04's APIGW, frontend on section 03's S3 |

---

## Repository Layout

```
.
├── main.tf                        # Root module — wires sections together
├── variables.tf                   # Root variables (region, enabled_sections, etc.)
├── providers.tf.example           # Copy to providers.tf and fill in your backend config
├── terraform.tfvars.example       # Copy to terraform.tfvars and fill in your values
├── Makefile                       # init / plan / apply / destroy
├── section-01-budgets/            # Budgets module
│   ├── providers.tf
│   ├── budgets.tf
│   ├── variables.tf
│   └── outputs.tf
├── section-02-ec2/                # EC2 module
│   ├── providers.tf
│   ├── ec2.tf
│   ├── ip_getter.tf
│   ├── key.tf
│   ├── variables.tf
│   └── outputs.tf
├── section-03-s3-cloudfront/      # S3 + CloudFront module
│   ├── providers.tf
│   ├── s3.tf
│   ├── cloudfront.tf
│   ├── variables.tf
│   └── outputs.tf
├── section-04-api-gateway/        # API Gateway module
│   ├── providers.tf
│   ├── api_gateway.tf
│   ├── variables.tf
│   └── outputs.tf
└── section-05-roulette/           # Roulette app module
    ├── providers.tf
    ├── dynamodb.tf
    ├── lambda.tf
    ├── handler.py
    ├── api_gateway.tf
    ├── frontend.tf
    ├── roulette.html
    ├── variables.tf
    └── outputs.tf
```

---

## GitHub Safety

The following are excluded from version control via `.gitignore`:

- `terraform.tfvars` — contains sensitive values (use `terraform.tfvars.example` as a template)
- `*.pem` — SSH private keys (e.g. `ec2-key.pem`)
- `.terraform/` — provider binaries
- `*.tfstate` / `*.tfstate.backup` — state files (contain sensitive infrastructure data)
- `*.tfplan` — saved plan files

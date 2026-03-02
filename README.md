# AWS Free Tier with Terraform — Tutorial

A step-by-step tutorial on using the **AWS Free Tier** with Terraform locally.
Each section is an independent Terraform project you can `init`, `plan`, and `apply` on its own.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- AWS credentials configured locally (`aws configure` or environment variables)
- An AWS account (free tier eligible for the first 12 months)

---

## Sections

### [Section 01 — Budgets](./section-01-budgets/)

Set a **$1 USD monthly budget** with email alerts at 80% and 100%.
This is your safety net — set it up first before spinning up any resources.

**Resources created:**
- `aws_budgets_budget` — monthly cost budget with two alert thresholds

---

### [Section 02 — EC2](./section-02-ec2/)

Launch a **free-tier EC2 instance** (t2.micro) running Amazon Linux 2023.
Terraform generates an SSH key pair for you — no manual setup needed.

**Resources created:**
- `tls_private_key` — generates a 4096-bit RSA key pair locally
- `aws_key_pair` — uploads the public key to AWS as `free-tier-ec2-key`
- `local_sensitive_file` — saves the private key to `ec2-key.pem` (permissions `0600`)
- `aws_security_group` — allows SSH inbound from `my_ip`, all outbound
- `aws_instance` — t2.micro with Amazon Linux 2023 and 8 GB gp3 volume

**After `make apply`, connect with:**
```bash
ssh -i ec2-key.pem ec2-user@<public_ip>
```

**Free tier limits to keep in mind:**
- 750 hours/month of t2.micro (enough for one instance running 24/7)
- 30 GB of EBS storage total
- Free tier applies for the first 12 months of your AWS account

---

## How each section works

Each section is a self-contained Terraform project. To work with a section:

```bash
cd section-01-budgets          # or section-02-ec2

cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with your values

make init
make plan
make apply
```

To tear down a section's resources:

```bash
make destroy
```

## Repository layout

```
.
├── section-01-budgets/
│   ├── providers.tf
│   ├── main.tf
│   ├── budgets.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── Makefile
└── section-02-ec2/
    ├── providers.tf
    ├── main.tf
    ├── ec2.tf
    ├── variables.tf
    ├── outputs.tf
    ├── terraform.tfvars.example
    └── Makefile
```

## GitHub Safety

The following are excluded from version control via `.gitignore`:

- `terraform.tfvars` — contains sensitive values (use `terraform.tfvars.example` as a template)
- `*.pem` — SSH private keys (e.g. `section-02-ec2/ec2-key.pem`)
- `.terraform/` — provider binaries
- `*.tfstate` / `*.tfstate.backup` — state files (contain sensitive infrastructure data)
- `*.tfplan` — saved plan files

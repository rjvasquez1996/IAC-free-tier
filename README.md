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
}
```

---

## Sections

### Section 01 — Budgets

Set a **$1 USD monthly budget** with email alerts at 80% and 100%.
This is your safety net — set it up first before spinning up any resources.

**Resources created:**
- `aws_budgets_budget` — monthly cost budget with two alert thresholds

**Variables:**
| Name | Description | Default |
|---|---|---|
| `budget_limit_usd` | Monthly budget limit in USD | `"1.0"` |
| `alert_email` | Email to receive budget alerts | *(required)* |

---

### Section 02 — EC2

Launch a **free-tier EC2 instance** (t2.micro) running Amazon Linux 2023.
Terraform generates an SSH key pair for you — no manual setup needed.

**Resources created:**
- `tls_private_key` — generates a 4096-bit RSA key pair locally
- `aws_key_pair` — uploads the public key to AWS as `free-tier-ec2-key`
- `local_sensitive_file` — saves the private key to `ec2-key.pem` (permissions `0600`)
- `aws_security_group` — allows SSH inbound from your current IP, all outbound
- `aws_instance` — t2.micro with Amazon Linux 2023 and 8 GB gp3 volume

**Variables:**
| Name | Description | Default |
|---|---|---|
| `instance_type` | EC2 instance type | `"t2.micro"` |

**After `make apply`, connect with:**
```bash
ssh -i ec2-key.pem ec2-user@<public_ip>
```

**Free tier limits to keep in mind:**
- 750 hours/month of t2.micro (enough for one instance running 24/7)
- 30 GB of EBS storage total
- Free tier applies for the first 12 months of your AWS account

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
└── section-02-ec2/                # EC2 module
    ├── providers.tf
    ├── ec2.tf
    ├── ip_getter.tf
    ├── key.tf
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

# Section 02 — EC2 / ECS

Launches a **free-tier EC2 instance** (Amazon Linux 2023 ECS-optimized) with an auto-generated SSH key pair.
No manual key management needed — Terraform creates and saves the key locally.

The application (Memos) can run in two mutually exclusive modes controlled by the `run_on_ecs` variable:

- **Standalone EC2** (`run_on_ecs = false`, default) — Docker runs Memos directly on the instance via `user_data.sh`
- **ECS on EC2** (`run_on_ecs = true`) — an ECS cluster is created, the instance registers as a container instance, and Memos runs as an ECS service

## Resources created

### Always created (both modes)

| Resource | Description |
|---|---|
| `tls_private_key` | Generates a 4096-bit RSA key pair locally |
| `aws_key_pair` | Uploads the public key to AWS as `free-tier-ec2-key` |
| `local_sensitive_file` | Saves the private key to `ec2-key.pem` (permissions `0600`) |
| `aws_security_group` | Allows port 5230 from anywhere and SSH from your current public IP |

### Standalone EC2 mode (`run_on_ecs = false`)

| Resource | Description |
|---|---|
| `aws_instance.free_tier` | t2.micro running Docker + Memos via user_data |

### ECS on EC2 mode (`run_on_ecs = true`)

| Resource | Description |
|---|---|
| `aws_iam_role.ecs_instance` | IAM role allowing the EC2 instance to register with ECS |
| `aws_iam_instance_profile.ecs_instance` | Instance profile attaching the IAM role to the EC2 instance |
| `aws_ecs_cluster.main` | ECS cluster (`memos-cluster`) |
| `aws_instance.ecs_container_instance` | t2.micro that registers as an ECS container instance |
| `aws_ecs_task_definition.memos` | Task definition running `neosmemo/memos:stable` on port 5230 |
| `aws_ecs_service.memos` | ECS service keeping one Memos task running |

## Variables

| Name | Description | Default |
|---|---|---|
| `instance_type` | EC2 instance type | `"t2.micro"` |
| `ami_id` | AMI ID to use (passed from root module) | *(required)* |
| `run_on_ecs` | `true` = ECS on EC2 mode, `false` = standalone Docker mode | `false` |

## Outputs

| Name | Description |
|---|---|
| `instance_id` | ID of the active EC2 instance |
| `public_ip` | Public IP address |
| `public_dns` | Public DNS name |
| `key_pair_name` | Name of the AWS key pair |
| `private_key_path` | Local path to the saved `ec2-key.pem` |

## Connect via SSH

After `make apply`:

```bash
ssh -i section-02-ec2/ec2-key.pem ec2-user@<public_ip>
```

## Choosing a mode

In `terraform.tfvars`:

```hcl
# Standalone EC2 with Docker (default)
run_on_ecs = false

# ECS cluster on EC2
run_on_ecs = true
```

Only one mode is active at a time. Switching between modes will destroy the current instance and create a new one.

## Free tier limits

- 750 hours/month of t2.micro (enough for one instance running 24/7)
- 30 GB of EBS gp2 storage
- Free tier applies for the first 12 months of your AWS account

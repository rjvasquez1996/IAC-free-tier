# Section 02 — EC2

Launches a **free-tier EC2 instance** (Amazon Linux 2023) with an auto-generated SSH key pair.
No manual key management needed — Terraform creates and saves the key locally.

## Resources created

| Resource | Description |
|---|---|
| `tls_private_key` | Generates a 4096-bit RSA key pair locally |
| `aws_key_pair` | Uploads the public key to AWS as `free-tier-ec2-key` |
| `local_sensitive_file` | Saves the private key to `ec2-key.pem` (permissions `0600`) |
| `aws_security_group` | Allows SSH from your current public IP and all outbound traffic |
| `aws_instance` | t2.micro with Amazon Linux 2023 and a 30 GB gp2 volume |

## Variables

| Name | Description | Default |
|---|---|---|
| `instance_type` | EC2 instance type | `"t2.micro"` |
| `ami_id` | AMI ID to use (passed from root module) | *(required)* |

## Outputs

| Name | Description |
|---|---|
| `instance_id` | ID of the EC2 instance |
| `public_ip` | Public IP address |
| `public_dns` | Public DNS name |
| `key_pair_name` | Name of the AWS key pair |
| `private_key_path` | Local path to the saved `ec2-key.pem` |

## Connect via SSH

After `make apply`:

```bash
ssh -i section-02-ec2/ec2-key.pem ec2-user@<public_ip>
```

## Free tier limits

- 750 hours/month of t2.micro (enough for one instance running 24/7)
- 30 GB of EBS gp2 storage
- Free tier applies for the first 12 months of your AWS account

## Enable / disable

In `terraform.tfvars`:

```hcl
enabled_sections = {
  section02 = true
}
```

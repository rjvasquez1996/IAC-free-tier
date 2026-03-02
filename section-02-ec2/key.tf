# Generate an RSA private key locally
resource "tls_private_key" "ec2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Upload the public key to AWS as a named key pair
resource "aws_key_pair" "ec2" {
  key_name   = "free-tier-ec2-key"
  public_key = tls_private_key.ec2.public_key_openssh
}

# Save the private key to disk so you can SSH into the instance
resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.ec2.private_key_pem
  filename        = "${path.module}/ec2-key.pem"
  file_permission = "0600"
}

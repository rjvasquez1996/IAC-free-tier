terraform {
  backend "s3" {
    bucket       = "rick-rob-student-community-day-backend"
    key          = "iac-scds/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

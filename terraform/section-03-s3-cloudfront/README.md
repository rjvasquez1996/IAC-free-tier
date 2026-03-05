# Section 03 — S3 + CloudFront Static Website

Hosts a **static website** on a private S3 bucket served globally through a **CloudFront distribution**.
Access to the bucket is restricted to CloudFront only via Origin Access Control (OAC) — no public bucket required.

## Architecture

```
User → CloudFront (HTTPS) → S3 bucket (private, OAC)
```

- All HTTP traffic is redirected to HTTPS by CloudFront
- S3 bucket blocks all public access; only CloudFront can read objects
- OAC (Origin Access Control) is used — the modern replacement for the deprecated OAI

## Resources created

| Resource | Description |
|---|---|
| `aws_s3_bucket` | Private S3 bucket to store website files |
| `aws_s3_bucket_public_access_block` | Blocks all public access to the bucket |
| `aws_s3_bucket_policy` | Grants CloudFront OAC read access via a bucket policy |
| `aws_cloudfront_origin_access_control` | OAC identity used by CloudFront to authenticate to S3 |
| `aws_cloudfront_distribution` | CloudFront distribution with HTTPS redirect and custom error pages |

## Variables

| Name | Description | Default |
|---|---|---|
| `bucket_name` | Globally unique S3 bucket name | *(required)* |
| `index_document` | Root document served by the website | `"index.html"` |
| `error_document` | Document served on 4xx errors | `"error.html"` |

## Outputs

| Name | Description |
|---|---|
| `bucket_name` | Name of the S3 bucket |
| `bucket_arn` | ARN of the S3 bucket |
| `cloudfront_domain_name` | CloudFront domain — use this as your website URL |
| `cloudfront_distribution_id` | CloudFront distribution ID |

## Uploading files

After `make apply`, upload your site files to the bucket:

```bash
aws s3 sync ./my-site/ s3://<bucket_name>/
```

Then open the CloudFront domain in your browser:

```
https://<cloudfront_domain_name>
```

## Invalidating the cache

After uploading new files, invalidate the CloudFront cache to serve the latest version immediately:

```bash
aws cloudfront create-invalidation \
  --distribution-id <cloudfront_distribution_id> \
  --paths "/*"
```

## Enable / disable

In `terraform.tfvars`:

```hcl
s3_bucket_name = "my-unique-bucket-name"

enabled_sections = {
  section03 = true
}
```

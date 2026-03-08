# Section 04 — API Gateway

Deploys an **HTTP API Gateway** with CORS configured to allow requests from the CloudFront domain created in section 03. Other sections (e.g. section 05) attach their own routes and integrations to this gateway.

## Architecture

```
Browser (CloudFront origin) → API Gateway (HTTP) → (integrations added by other sections)
```

- CORS `allowed_origins` is sourced directly from the `cloudfront_domain_name` output of the `s3_website` module — no manual configuration needed

## Requirements

**Section 03 must be enabled** before deploying section 04, as the API Gateway CORS origin is derived from the CloudFront distribution created there.

## Resources created

| Resource | Description |
|---|---|
| `aws_apigatewayv2_api` | HTTP API with CORS configured for the CloudFront origin |
| `aws_apigatewayv2_stage` | `$default` stage with auto-deploy enabled |

## Variables

| Name | Description | Default |
|---|---|---|
| `api_name` | Name prefix for the API Gateway | *(required)* |

## Outputs

| Name | Description |
|---|---|
| `api_endpoint` | Base URL of the HTTP API (e.g. `https://xxx.execute-api.region.amazonaws.com`) |
| `api_id` | ID of the HTTP API Gateway |
| `api_execution_arn` | Execution ARN of the HTTP API Gateway |

## Enable / disable

In `terraform.tfvars` (section 03 must also be enabled):

```hcl
api_name = "my-api"

enabled_sections = {
  section03 = true
  section04 = true
}
```

# Section 04 — API Gateway + Lambda

Deploys an **HTTP API Gateway** backed by a **Lambda function**, with CORS configured to allow requests from the CloudFront domain created in section 03.

## Architecture

```
Browser (CloudFront origin) → API Gateway (HTTP) → Lambda (Python 3.12)
```

- CORS `allowed_origins` is sourced directly from the `cloudfront_domain_name` output of the `s3_website` module — no manual configuration needed
- Lambda ships with a placeholder handler that returns a JSON response; replace `handler.py` with your own logic

## Requirements

**Section 03 must be enabled** before deploying section 04, as the API Gateway CORS origin is derived from the CloudFront distribution created there.

## Resources created

| Resource | Description |
|---|---|
| `aws_apigatewayv2_api` | HTTP API with CORS configured for the CloudFront origin |
| `aws_apigatewayv2_integration` | Lambda proxy integration |
| `aws_apigatewayv2_route` | `GET /hello` route wired to the Lambda |
| `aws_apigatewayv2_stage` | `$default` stage with auto-deploy enabled |
| `aws_lambda_function` | Python 3.12 function deployed from `handler.py` |
| `aws_iam_role` | Execution role with `AWSLambdaBasicExecutionRole` |
| `aws_lambda_permission` | Grants API Gateway permission to invoke the Lambda |

## Variables

| Name | Description | Default |
|---|---|---|
| `api_name` | Name prefix for the API Gateway and Lambda resources | *(required)* |

## Outputs

| Name | Description |
|---|---|
| `api_endpoint` | Base URL of the HTTP API (e.g. `https://xxx.execute-api.region.amazonaws.com`) |
| `lambda_function_name` | Name of the deployed Lambda function |

## Testing the endpoint

After `make apply`, call the route:

```bash
curl https://<api_endpoint>/hello
# {"message": "Hello from Lambda!"}
```

## Enable / disable

In `terraform.tfvars` (section 03 must also be enabled):

```hcl
api_name = "my-api"

enabled_sections = {
  section03 = true
  section04 = true
}
```

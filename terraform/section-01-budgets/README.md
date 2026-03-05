# Section 01 — Budgets

Sets a **monthly cost budget** in AWS Cost Explorer with email alerts at 80% and 100% of the limit.
Deploy this first — it's your safety net before spinning up any billable resources.

## Resources created

| Resource | Description |
|---|---|
| `aws_budgets_budget` | Monthly cost budget with two alert thresholds (80% and 100%) |

## Variables

| Name | Description | Default |
|---|---|---|
| `budget_limit_usd` | Monthly budget limit in USD | `"1.0"` |
| `alert_email` | Email address to receive alert notifications | *(required)* |

## Outputs

| Name | Description |
|---|---|
| `budget_name` | Name of the created AWS budget |

## Enable / disable

In `terraform.tfvars`:

```hcl
enabled_sections = {
  section01 = true
}
```

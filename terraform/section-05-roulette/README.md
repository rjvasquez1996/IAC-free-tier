# Section 05 - Roulette App

A serverless roulette/raffle application using DynamoDB + Lambda, plugging into the API Gateway created by Section 04.

## Architecture

- **DynamoDB** table stores registered users (`id`, `name`)
- **Lambda** (Python 3.12) handles CRUD operations and winner selection
- **API Gateway routes** added to Section 04's HTTP API
- **Frontend** (roulette.html) uploaded to Section 03's S3 bucket

## API Routes

| Route | Method | Action |
|---|---|---|
| `/roulette/users` | GET | List all registered users |
| `/roulette/users` | POST | Register user (`{"name": "..."}`) |
| `/roulette/users/{id}` | DELETE | Remove user by UUID |
| `/roulette/pick` | POST | Pick random winner and remove from table |

## Dependencies

Requires Section 03 (S3) and Section 04 (API Gateway) to be enabled.

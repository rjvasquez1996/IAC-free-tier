import json
import os
import uuid
import random
import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def lambda_handler(event, context):
    method = event.get("requestContext", {}).get("http", {}).get("method", "")
    path = event.get("rawPath", "")

    if path == "/roulette/users" and method == "GET":
        return list_users()
    elif path == "/roulette/users" and method == "POST":
        return register_user(event)
    elif path.startswith("/roulette/users/") and method == "DELETE":
        user_id = path.split("/")[-1]
        return deregister_user(user_id)
    elif path == "/roulette/pick" and method == "POST":
        return pick_winner()
    else:
        return response(404, {"error": "Not found"})


def list_users():
    result = table.scan()
    users = result.get("Items", [])
    return response(200, users)


def register_user(event):
    body = json.loads(event.get("body", "{}"))
    name = body.get("name", "").strip()
    if not name:
        return response(400, {"error": "name is required"})

    existing = table.scan()
    for user in existing.get("Items", []):
        if user["name"].lower() == name.lower():
            return response(409, {"error": f"'{name}' is already registered, please use a different name"})

    user_id = str(uuid.uuid4())
    table.put_item(Item={"id": user_id, "name": name})
    return response(201, {"id": user_id, "name": name})


def deregister_user(user_id):
    table.delete_item(Key={"id": user_id})
    return response(200, {"deleted": user_id})


def pick_winner():
    result = table.scan()
    users = result.get("Items", [])
    if not users:
        return response(400, {"error": "No users registered"})

    winner = random.choice(users)
    table.delete_item(Key={"id": winner["id"]})
    return response(200, {"winner": winner})


def response(status_code, body):
    return {
        "statusCode": status_code,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(body),
    }

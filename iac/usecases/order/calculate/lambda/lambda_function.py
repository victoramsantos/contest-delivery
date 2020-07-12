import json
import boto3
import os
import pymysql

from botocore.exceptions import ClientError

def get_secret(secret_name):
    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
        return get_secret_value_response['SecretString']
    except ClientError as e:
        print(f"Error: {e.response['Error']['Code']}")
        raise e
    except Exception as e:
        print(f"Unexpected Error: {str(e)}")
        raise e


def db_connection(hostname, username, password, database):
    try:
        return pymysql.connect(hostname, user=username, passwd=password, db=database, connect_timeout=3)
    except Exception as e:
        print(str(e))
        raise e

def filter_products(order, conn):
    products = []
    ids = [product["id"] for product in order]
    query = f"select * from products where id in {tuple(ids)}"
    with conn.cursor() as cur:
        cur.execute(query)
        for elem in cur:
            products.append(elem)

    return products

def calculate_order(order, products):
    total = 0
    for product in products:
        for item in order:
            if product[0] == item["id"]:
                total += product[2] * item["amount"]

    return total

def lambda_handler(event, context):
    body = json.loads(event["body"])
    conn = db_connection(hostname, username, password, database)

    order = body["order"]
    products = filter_products(order, conn)
    total = calculate_order(order, products)

    return {
        'statusCode': 200,
        'body': json.dumps({
            "products": products,
            "total": total
        })
    }


region_name = "us-east-1"

session = boto3.session.Session()
client = session.client(
    service_name='secretsmanager',
    region_name=region_name
)

hostname = os.getenv("DATABASE_ADDRESS")
database = os.getenv("DATABASE_NAME")
username = get_secret("order-db-username")
password = get_secret("order-db-password")
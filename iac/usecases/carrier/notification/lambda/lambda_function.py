import json
import boto3
import os


def lambda_handler(event, context):
    client = boto3.client('sns')
    sns_arn = os.getenv("SNS_ARN")

    message = event["message"]

    response = client.publish(
        TargetArn=sns_arn,
        Message=message
    )

    return {
        'statusCode': 200,
        'body': json.dumps({
            "status": "The message was sent"
        })
    }

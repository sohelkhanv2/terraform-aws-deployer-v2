import json

print("Hello from Terraform")

def lambda_handler(event, context):
    print("Lambda executed successfully!")
    print('now lambda')
    print("testing terraform with update the lambda function")
    print("inside test trigger lambda function")
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

import json

print("Hello from Terraform")
print("Hello from Terraform again")

def lambda_handler(event, context):
    print("Lambda executed successfully!")
    print('now lambda')
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

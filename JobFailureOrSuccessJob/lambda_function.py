import boto3
import os
import json

sns = boto3.client('sns')
SNS_TOPIC = os.environ['SNS_TOPIC']

def lambda_handler(event, context):
    print("Event Received:")
    # print(json.dumps(event, indent=2))
    print(json.dumps(event))

    alert_type = event.get("alertType", "UNKNOWN")
    
    if alert_type == "FAILURE":
        subject = "Glue Job Failed"
        # message = json.dumps(event.get("error", {}), indent=2)
        message = json.dumps(event.get("error", {}))
        print("prints the Message:", message)
        print("testing terraform")
        print("testing terraform with update the lambda function")
        print("inside the lambda function job failure or success job")
        print("inside the lambda function job failure or success job just to test the terraform")

    elif alert_type == "SUCCESS":
        subject = "All Glue Jobs Completed Successfully"
        message = "All Glue jobs and Step Function execution completed successfully."
    else:
        subject = "Unknown Alert Type"
        message = str(event)
    
    sns.publish(
        TopicArn=SNS_TOPIC,
        Subject=subject,
        Message=message
    )
    
    return {"status": "Alert Sent", "type": alert_type}

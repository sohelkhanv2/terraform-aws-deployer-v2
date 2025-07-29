
# aws_lambda_function.JobFailureOrSuccessAlertsLambda:
resource "aws_lambda_function" "JobFailureOrSuccessAlertsLambda" {
  function_name = "JobFailureOrSuccessAlertsLambda"
  role          = "arn:aws:iam::911462567973:role/service-role/JobFailureOrSuccessAlertsLambda-role-534kc2g9"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  architectures = ["x86_64"]
  memory_size   = 128
  timeout       = 3
  package_type  = "Zip"
  filename      = "JobFailureOrSuccessJob/JobFailureOrSuccessAlertsLambda.zip"
  source_code_hash = filebase64sha256("JobFailureOrSuccessJob/JobFailureOrSuccessAlertsLambda.zip")

  environment {
    variables = {
      SNS_TOPIC = "arn:aws:sns:us-east-2:911462567973:JobFailureOrSuccessAlerts"
    }
  }

  ephemeral_storage {
    size = 512
  }

  logging_config {
    log_format  = "Text"
    log_group   = "/aws/lambda/JobFailureOrSuccessAlertsLambda"
  }

  tracing_config {
    mode = "PassThrough"
  }

  # Optional tags (add if needed)
  # tags = {
  #   Environment = "prod"
  # }
}



resource "aws_lambda_function" "test-lambda-trigger" {
  function_name = "test-lambda-trigger"
  role          = "arn:aws:iam::911462567973:role/service-role/test-lambda-trigger-role-55hapd35"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  architectures = ["x86_64"]
  memory_size   = 128
  timeout       = 3
  package_type  = "Zip"
  filename      = "${path.module}/Test-Trigger-Lambda/test-lambda-trigger.zip"
  source_code_hash = filebase64sha256("Test-Trigger-Lambda/test-lambda-trigger.zip")

  ephemeral_storage {
    size = 512
  }

  logging_config {
    log_format  = "Text"
    log_group   = "/aws/lambda/test-lambda-trigger"
  }

  tracing_config {
    mode = "PassThrough"
  }

  # Optional: Add environment variables if needed
  # environment {
  #   variables = {
  #     KEY = "value"
  #   }
  # }

  # Optional: Add tags if needed
  # tags = {
  #   Name        = "test-lambda-trigger"
  #   Environment = "dev"
  # }
}

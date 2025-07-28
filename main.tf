provider "aws" {
  region = "us-east-2"
}

resource "aws_sfn_state_machine" "sample_terraform_machine" {
  name     = var.step_function_name
  role_arn = var.step_function_role_arn

  definition = jsonencode({
    Comment = "Centralized Alerting with 2 Glue Jobs and Inner Step Function"
    StartAt = "Glue Job 1"
    States = {
      "Glue Job 1" = {
        Type       = "Task"
        Resource   = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = var.glue_job1_name
        }
        Catch = [{
          ErrorEquals = ["States.ALL"]
          ResultPath  = "$.errorInfo"
          Next        = "Failure Alert"
        }]
        Next = "Glue Job 2"
      }

      "Glue Job 2" = {
        Type       = "Task"
        Resource   = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = var.glue_job2_name
        }
        Catch = [{
          ErrorEquals = ["States.ALL"]
          ResultPath  = "$.errorInfo"
          Next        = "Failure Alert"
        }]
        Next = "Invoke Inner Step Function"
      }

      "Invoke Inner Step Function" = {
        Type       = "Task"
        Resource   = "arn:aws:states:::states:startExecution.sync:2"
        Parameters = {
          StateMachineArn = var.inner_step_function_arn
          Input = {
            "AWS_STEP_FUNCTIONS_STARTED_BY_EXECUTION_ID.$" = "$$.Execution.Id"
            StatePayload = "Hello from Step Functions!"
          }
        }
        Catch = [{
          ErrorEquals = ["States.ALL"]
          ResultPath  = "$.errorInfo"
          Next        = "Add JobName Inner Step Function"
        }]
        Next = "Success Alert"
      }

      "Add JobName Inner Step Function" = {
        Type = "Pass"
        Parameters = {
          "jobName"          = "Inner Step Function"
          "status"           = "FAILED"
          "stepfunction"     = "Main Step Function"
          "alertAlreadySent" = true
          "errorInfo.$"      = "$.errorInfo"
        }
        Next = "Failure Alert"
      }

      "Failure Alert" = {
        Type     = "Task"
        Resource = var.alert_lambda_function_arn
        Parameters = {
          "jobName.$"      = "$.jobName"
          "status.$"       = "$.status"
          "stepfunction.$" = "$.stepfunction"
          "errorType.$"    = "$.errorInfo.Error"
          "cause.$"        = "$.errorInfo.Cause"
        }
        End = true
      }

      "Success Alert" = {
        Type     = "Task"
        Resource = var.alert_lambda_function_arn
        Parameters = {
          status       = "SUCCESS"
          stepfunction = "Main Step Function"
        }
        End = true
      }
    }
  })

  type = "STANDARD"

  logging_configuration {
    level                  = "OFF"
    include_execution_data = false
  }

  tracing_configuration {
    enabled = false
  }

}



resource "aws_sfn_state_machine" "inner_step_function_v2" {
  name     = "inner-step-function-v2"
  role_arn = var.inner_step_function_role_arn
  type     = "STANDARD"
  definition = local.inner_step_function_definition


  logging_configuration {
    level                  = "OFF"
    include_execution_data = false
  }

  tracing_configuration {
    enabled = false
  }
}

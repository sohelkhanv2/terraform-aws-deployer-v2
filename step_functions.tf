locals {
  main_step_function_definition = jsonencode({
    Comment = "Centralized Alerting with 2 Glue Jobs and Inner Step Function"
    StartAt = "Glue Job 1"
    States = {
      "Glue Job 1" = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = "terraform-job1"
        }
        Catch = [
          {
            ErrorEquals = ["States.ALL"]
            ResultPath  = "$.errorInfo"
            Next        = "Failure Alert"
          }
          
        ]
        Next = "Glue Job 2"
      }

      "Glue Job 2" = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = "terraform-job2"
        }
        Catch = [
          {
            ErrorEquals = ["States.ALL"]
            ResultPath  = "$.errorInfo"
            Next        = "Failure Alert"
          }
        ]
        Next = "Invoke Inner Step Function"
      }

      "Invoke Inner Step Function" = {
        Type     = "Task"
        Resource = "arn:aws:states:::states:startExecution.sync:2"
        Parameters = {
          StateMachineArn = "arn:aws:states:us-east-2:911462567973:stateMachine:inner-step-function-v2"
          Input = {
            "AWS_STEP_FUNCTIONS_STARTED_BY_EXECUTION_ID.$" = "$$.Execution.Id"
            StatePayload = "Hello from Step Functions!"
          }
        }
        Catch = [
          {
            ErrorEquals = ["States.ALL"]
            ResultPath  = "$.errorInfo"
            Next        = "Add JobName Inner Step Function"
          }
        ]
        Next = "Success Alert"
      }

      "Add JobName Inner Step Function" = {
        Type = "Pass"
        Parameters = {
          jobName          = "Inner Step Function"
          stepfunction     = "Main Step Function"
          status           = "FAILED"
          alertAlreadySent = true
          "errorInfo.$"    = "$.errorInfo"
        }
        Next = "Failure Alert"
      }

      "Failure Alert" = {
        Type     = "Task"
        Resource = "arn:aws:lambda:us-east-2:911462567973:function:JobFailureOrSuccessAlertsLambda"
        Parameters = {
          "jobName.$"      = "$.jobName"
          "stepfunction.$" = "$.stepfunction"
          "status.$"       = "$.status"
          "errorType.$"    = "$.errorInfo.Error"
          "cause.$"        = "$.errorInfo.Cause"
        }
        End = true
      }

      "Success Alert" = {
        Type     = "Task"
        Resource = "arn:aws:lambda:us-east-2:911462567973:function:JobFailureOrSuccessAlertsLambda"
        Parameters = {
          status       = "SUCCESS"
          stepfunction = "Main Step Function"
        }
        End = true
      }
    }
  })
}


locals {
  inner_step_function_definition = jsonencode({
    Comment = "Pipeline with single alerting state for all failures and one final success alert"
    StartAt = "Glue StartJobRun"
    States = {
      "Glue StartJobRun" = {
        Type       = "Task"
        Resource   = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = var.glue_inner_job_name
        }
        Next = "Call Lambda"
      }

      "Call Lambda" = {
        Type     = "Task"
        Resource = var.inner_lambda_function_arn
        Parameters = {
          fail = false
        }
        End = true
      }
    }
  })
}

variable "s3_bucket_name" {
  description = "S3 bucket for storing Glue scripts and temp data"
  type        = string
  default     = "pipeline-tf-sample"
}

variable "glue_job_role_arn" {
  description = "IAM role ARN for AWS Glue job"
  type        = string
  default     = "arn:aws:iam::911462567973:role/ccm_pipeline_glue_role"
}

variable "step_function_name" {
  description = "Name of the Step Function state machine"
  type        = string
  default     = "sample-terraform-machine"
}

variable "step_function_role_arn" {
  description = "ARN of the IAM role for Step Function execution"
  type        = string
  default     = "arn:aws:iam::911462567973:role/service-role/StepFunctions-sample-terraform-machine-role-1tlaqcfo1"
}

variable "inner_step_function_arn" {
  description = "ARN of the inner step function to be invoked"
  type        = string
  default     = "arn:aws:states:us-east-2:911462567973:stateMachine:inner-step-function-v2"
}

variable "alert_lambda_function_arn" {
  description = "ARN of the Lambda used for failure/success alerts"
  type        = string
  default     = "arn:aws:lambda:us-east-2:911462567973:function:JobFailureOrSuccessAlertsLambda"
}

variable "glue_job1_name" {
  description = "Name of Glue Job 1"
  type        = string
  default     = "terraform-job1"
}

variable "glue_job2_name" {
  description = "Name of Glue Job 2"
  type        = string
  default     = "terraform-job2"
}


variable "inner_step_function_role_arn" {
  description = "IAM Role ARN for the inner Step Function"
  type        = string
  default     = "arn:aws:iam::911462567973:role/service-role/StepFunctions-inner-step-function-v2-role-bj8nvvr9h"
}

variable "glue_inner_job_name" {
  description = "Glue job name used inside inner step function"
  type        = string
  default     = "testalert3"
}

variable "inner_lambda_function_arn" {
  description = "Lambda function ARN to be called in inner step function"
  type        = string
  default     = "arn:aws:lambda:us-east-2:911462567973:function:test-lambda-trigger"
}

# Upload the script to S3
resource "aws_s3_object" "terraform_job1_script" {
  bucket  = var.s3_bucket_name
  key     = "glue/scripts/terraform-job1.py"
  content = file("${path.module}/Glue_Jobs/terraform-job1.py")
}

# Create the Glue job
resource "aws_glue_job" "terraform_job1" {
  name     = "terraform-job1"
  role_arn = var.glue_job_role_arn

  glue_version       = "5.0"
  number_of_workers  = 10
  worker_type        = "G.1X"
  max_retries        = 0
  timeout            = 480
  execution_class    = "STANDARD"
  job_run_queuing_enabled = false
  connections        = ["Jdbc connection"]

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_object.terraform_job1_script.bucket}/${aws_s3_object.terraform_job1_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--TempDir"                      = "s3://${var.s3_bucket_name}/temporary/"
    "--enable-glue-datacatalog"      = "true"
    "--enable-job-insights"          = "true"
    "--enable-metrics"               = "true"
    "--enable-observability-metrics" = "true"
    "--enable-spark-ui"              = "true"
    "--job-bookmark-option"          = "job-bookmark-disable"
    "--job-language"                 = "python"
    "--spark-event-logs-path"        = "s3://${var.s3_bucket_name}/sparkHistoryLogs/"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


# Upload the script to S3
resource "aws_s3_object" "terraform_job2_script" {
  bucket  = var.s3_bucket_name
  key     = "glue/scripts/terraform-job2.py"
  content = file("${path.module}/Glue_Jobs/terraform-job2.py")
}

# Define the Glue Job
resource "aws_glue_job" "terraform_job2" {
  name     = "terraform-job2"
  role_arn = var.glue_job_role_arn

  glue_version       = "5.0"
  number_of_workers  = 10
  worker_type        = "G.1X"
  max_retries        = 0
  timeout            = 480
  execution_class    = "STANDARD"
  job_run_queuing_enabled = false

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_object.terraform_job2_script.bucket}/${aws_s3_object.terraform_job2_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--TempDir"                      = "s3://${var.s3_bucket_name}/temporary/"
    "--enable-glue-datacatalog"      = "true"
    "--enable-job-insights"          = "true"
    "--enable-metrics"               = "true"
    "--enable-observability-metrics" = "true"
    "--enable-spark-ui"              = "true"
    "--job-bookmark-option"          = "job-bookmark-disable"
    "--job-language"                 = "python"
    "--spark-event-logs-path"        = "s3://${var.s3_bucket_name}/sparkHistoryLogs/"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}



# Upload the script to S3
resource "aws_s3_object" "testalert3_script" {
  bucket  = var.s3_bucket_name
  key     = "glue/scripts/testalert3.py"
  content = file("${path.module}/Glue_Jobs/testalert3.py")
}

# Create the Glue job
resource "aws_glue_job" "testalert3" {
  name     = "testalert3"
  role_arn = var.glue_job_role_arn

  glue_version       = "5.0"
  number_of_workers  = 10
  worker_type        = "G.1X"
  max_retries        = 0
  timeout            = 480
  execution_class    = "STANDARD"
  job_run_queuing_enabled = false

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_object.testalert3_script.bucket}/${aws_s3_object.testalert3_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--TempDir"                      = "s3://${var.s3_bucket_name}/temporary/"
    "--enable-glue-datacatalog"      = "true"
    "--enable-job-insights"          = "true"
    "--enable-metrics"               = "true"
    "--enable-observability-metrics" = "true"
    "--enable-spark-ui"              = "true"
    "--job-bookmark-option"          = "job-bookmark-disable"
    "--job-language"                 = "python"
    "--spark-event-logs-path"        = "s3://${var.s3_bucket_name}/sparkHistoryLogs/"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

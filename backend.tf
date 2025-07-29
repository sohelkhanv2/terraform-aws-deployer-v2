terraform {
  backend "s3" {
    bucket = "terraform-test-backend-v2"
    key    = "lambda/terraform.tfstate"
    region = "us-east-2"
  }
}

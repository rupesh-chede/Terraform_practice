terraform {
  backend "s3" {
    bucket = "test-one-new-7418596"
    key = "day-3/terraform.tfstate"
    region = "us-east-1"
    
  }
}
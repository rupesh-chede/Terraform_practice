terraform {
  backend "s3" {
    use_lockfile = true
    bucket = "test-one-new-7418596"
    key = "day-7/terraform.tfstate"
    region = "us-east-1"
    
  }
}
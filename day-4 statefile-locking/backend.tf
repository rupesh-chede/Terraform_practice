terraform {
  backend "s3" {
    bucket = "test-one-new-7418596"
    key = "day-4/terraform.tfstate"
    use_lockfile = true # to use s3 native locking 1.19 version above
    region = "us-east-1"
    
  }
}
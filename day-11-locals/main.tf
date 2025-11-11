locals {
  bucket-name="${var.layer}-${var.env}-bucket-skyops-team"
  region = "us-east-1"
}

resource "aws_s3_bucket" "name" {
    bucket = local.bucket-name
    region = local.region
    tags = {
      Name = local.bucket-name
      Environment = var.env
    }
  
}
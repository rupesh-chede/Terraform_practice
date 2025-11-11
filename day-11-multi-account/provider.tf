provider "aws" {
    region = "us-east-1"
  
}

provider "aws" {
    region = "us-west-2"
    alias = "us-west"
    profile = "rupesh2"
  
}
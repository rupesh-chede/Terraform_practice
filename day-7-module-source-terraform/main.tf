module "name" {
    source = "terraform-aws-modules/s3-bucket/aws"

    bucket = "test-one-bucket-skyops-741785"
    acl = "private"

    control_object_ownership = true
    object_ownership = "ObjectWriter"

    versioning = {
            enable = true
    }
  
}
resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    key_name = "test"
    security_groups = [ "default" ]
    instance_type = "t3.micro"
    tags = {
      Name = "test"
    }

}

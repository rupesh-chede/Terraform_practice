resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    key_name = "test"
    security_groups = [ "default" ]
    instance_type = "t3.micro"
    tags = {
      Name = "test"
    }

}

# command is a $terraform import aws_instance.name i-0d57c2efba9128f62

resource "aws_instance" "frontend" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.frontend1.id
    vpc_security_group_ids = [ aws_security_group.frontend_sg.id ]
    availability_zone = "us-east-1a"
    key_name = "test"

    tags = {
      Name = "Frontend server"
    }
  
}

resource "aws_instance" "frontend1" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.frontend2.id
    vpc_security_group_ids = [ aws_security_group.frontend_sg.id ]
    availability_zone = "us-east-1b"
    key_name = "test"

    tags = {
      Name = "Frontend server"
    }
  
}


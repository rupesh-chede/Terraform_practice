resource "aws_instance" "backend_server" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.backend1.id
    vpc_security_group_ids = [ aws_security_group.backend_sg.id ]
    key_name = "test"
    availability_zone = "us-east-1a"

    tags = {
      Name = "Backend-server"
    }
  
}

resource "aws_instance" "backend_server1" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.backend2.id
    vpc_security_group_ids = [ aws_security_group.backend_sg.id ]
    key_name = "test"
    availability_zone = "us-east-1b"

    tags = {
      Name = "Backend-server"
    }
  
}
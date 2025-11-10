resource "aws_instance" "bastion_ec2" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public1.id
    vpc_security_group_ids = [ aws_security_group.public_sg.id ]
    availability_zone = "us-east-1a"
    key_name = "test"
    associate_public_ip_address = true
    

    tags = {
      Name = "Bastion server"
    }
  
}
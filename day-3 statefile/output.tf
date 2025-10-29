output "ec2-public-ip" {
    value = aws_instance.name.public_ip
}

output "ec2-private-ip" {
    value = aws_instance.name.private_ip
  
}

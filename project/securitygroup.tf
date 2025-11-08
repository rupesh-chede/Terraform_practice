# Bastion Public    public_sg                   22
# Frontend ALB  	alb_frontend_sg	0.0.0.0/0	80
# Frontend EC2	    frontend_sg	alb_frontend_sg	80
# Backend ALB   	alb_backend_sg	frontend_sg	8080
# Backend EC2	    backend_sg	alb_backend_sg	8080
# RDS	rds_sg  	backend_sg	                3306


#public servers 
resource "aws_security_group" "public_sg" {
    vpc_id = aws_vpc.dev.id
    name = "public_sg"
    description = "Allow for bastion"

    ingress {
        description = "Allow ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "for http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "Public-sg"
    }
}

# ------------------------ #
# Load Balancer Security Group
# ------------------------ #
resource "aws_security_group" "alb_frontend_sg" {
  name        = "alb-frontend-sg"
  description = "Allow HTTP from anywhere"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-frontend-sg"
  }
}


#frontend security group
#use only frontend 
resource "aws_security_group" "frontend_sg" {
    description = "frontend sg"
    name = "pvt_sg"
    vpc_id = aws_vpc.dev.id

    ingress {
        description = "for bastion"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [ aws_security_group.public_sg.id ]
    }

    ingress {
        description = "only for frontend alb sg"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [ aws_security_group.alb_frontend_sg.id ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "Frontend-SG"
    }
  
}

#backend alb security group
resource "aws_security_group" "alb_backend_sg" {
    vpc_id = aws_vpc.dev.id
    name = "alb-backend-sg"
    description = "allow only frontend sg"

    ingress {
        description = "for bastion"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [ aws_security_group.public_sg.id ]
    }

    ingress {
        description = "from frontend server"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        security_groups = [ aws_security_group.frontend_sg.id ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "alb-backend-sg"
    }
  
}

# ------------------------ #
# Backend EC2 SG
# ------------------------ #
resource "aws_security_group" "backend_sg" {
    name = "backend-sg"
    description = "allow from backend alb sg only"
    vpc_id = aws_vpc.dev.id

    ingress {
        description = "for bastion"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [ aws_security_group.public_sg.id ]
    }

    ingress {
        description = "from backend sg "
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        security_groups = [ aws_security_group.alb_backend_sg.id ]
    }

    tags = {
      Name = "Backend-sg"
    }
  
}

# ------------------------ #
# RDS SG (Accept only backend EC2)
# ------------------------ #
resource "aws_security_group" "rds_sg" {
    name = "rds-sg"
    description = "allow mysql only from backend server"
    vpc_id = aws_vpc.dev.id

    ingress {
        description = "mysql from backend server"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ aws_security_group.backend_sg.id ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "rds-sg"
    }
  
}
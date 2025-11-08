resource "aws_lb" "backend_alb" {
    name = "backend-alb"
    load_balancer_type = "application"
    internal = false
    security_groups = [ aws_security_group.alb_backend_sg.id ]
    subnets = [ 
        aws_subnet.public1.id,
        aws_subnet.backend2.id
     ]
    
    tags = {
      Name = "backend-alb"
    }
}

resource "aws_lb_target_group" "backend_tg" {
    name = "backend-tg"
    port = 8080
    protocol = "HTTP"
    vpc_id = aws_vpc.dev.id

    health_check {
      path = "/"
      port = 8080
    }

    tags = {
      Name = "Backend-tg"
    }
}

resource "aws_lb_listener" "backend_listener" {
    load_balancer_arn = aws_lb.backend_alb.arn
    port = 8080
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.backend_tg.arn
    }
}

resource "aws_lb_target_group_attachment" "backend_attachement" {
    target_group_arn = aws_lb_target_group.backend_tg.arn
    target_id = aws_instance.backend_server.id
    port = 8080
  
}
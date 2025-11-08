resource "aws_lb" "frontend_alb" {
    name = "frontend-alb"
    load_balancer_type = "application"
    internal = false
    security_groups = [ aws_security_group.alb_frontend_sg.id ]
    subnets = [ 
        aws_subnet.public1.id,
        aws_subnet.public2.id
     ]

     tags = {
       Name = "Frontend-alb"
     }
  
}

resource "aws_lb_target_group" "frontend_tg" {
    name = "frontend-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.dev.id

    health_check {
      path = "/"
    }

    tags = {
      Name = "frontend-tg"
    }
  
}

resource "aws_lb_listener" "frontend_listener" {
    load_balancer_arn = aws_lb.frontend_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.frontend_tg.arn
    }
}

resource "aws_lb_target_group_attachment" "frontend_attachement" {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    target_id = aws_instance.frontend.id
    port = 80
  
}
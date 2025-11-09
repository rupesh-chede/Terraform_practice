output "Frontend_lb_url" {
    value = aws_lb.frontend_alb.dns_name
  
}

output "Backend_lb_url" {
    value = aws_lb.backend_alb.dns_name
  
}
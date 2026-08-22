resource "aws_ssm_parameter" "public_alb_listener_arn" { #storing the Listener ARN in the Parameter Store.
  name  = "/${var.project}/${var.environment}/public_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.https.arn
  overwrite = true
}
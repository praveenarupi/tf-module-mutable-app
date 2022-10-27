resource "aws_lb_target_group_attachment" "tg" {
  count            = length(local.ALL_INSTANCE_IDS)
  target_group_arn =  data.terraform_remote_state.infra.outputs.public_tg_arn
  target_id        = local.ALL_INSTANCE_IDS[count.index]
  port             = 80
}

resource "aws_lb_target_group" "tg" {
  name                 = "${var.COMPONENT}-${var.ENV}"
  port                 = var.APP_PORT
  protocol             = "HTTP"
  vpc_id               = data.terraform_remote_state.infra.outputs.vpc_id
  health_check {
    enabled = true
    healthy_threshold = 2
    interval = 5
    timeout = 4
    port = var.APP_PORT
    unhealthy_threshold = 2
    
  }
}
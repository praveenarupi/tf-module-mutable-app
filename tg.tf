resource "aws_lb_target_group_attachment" "tg" {
  count            = length(local.ALL_INSTANCE_IDS)
  target_group_arn =  data.terraform_remote_state.infra.outputs.public_tg_arn
  target_id        = local.ALL_INSTANCE_IDS[count.index]
  port             = 80
}
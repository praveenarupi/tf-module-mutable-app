locals {
  ssh_password          = element(split("/", data.aws_ssm_parameter.ssh_credentials.value), 1)
  ssh_username          = element(split("/", data.aws_ssm_parameter.ssh_credentials.value), 0)
  SPOT_INSTANCE_IDS     = aws_spot_instance_request.spot.*.spot_instance_id
  ONDEMAND_INSTANCE_IDS = aws_instance.ondemand.*.id
  ALL_INSTANCE_IDS      = concat(local.SPOT_INSTANCE_IDS, local.ONDEMAND_INSTANCE_IDS)
  SPOT_PRIVATE_IPS      = aws_spot_instance_request.spot.*.private_ip
  ONDEMAND_PRIVATE_IPS  = aws_instance.ondemand.*.private_ip
  ALL_PRIVATE_IPS       = concat(local.SPOT_PRIVATE_IPS, local.ONDEMAND_PRIVATE_IPS)
}
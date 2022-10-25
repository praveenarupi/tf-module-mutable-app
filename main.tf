resource "aws_instance" "ondemand" {
  count                  = var.INSTANCES["ONDEMAND"].instance_count
  instance_type          = var.INSTANCES["ONDEMAND"].instance_type
  ami                    = data.aws_ami.ami.image_id
  subnet_id = data.terraform_remote_state.infra.outputs.app_subnets[count.index]
}

resource "aws_spot_instance_request" "spot" {
  count                  = var.INSTANCES["SPOT"].instance_count
  instance_type          = var.INSTANCES["SPOT"].instance_type
  ami                    = data.aws_ami.ami.image_id
  subnet_id = data.terraform_remote_state.infra.outputs.app_subnets[count.index]
  wait_for_fulfillment   = true
}

resource "aws_ec2_tag" "name-tag" {
  count       = length(local.ALL_INSTANCE_IDS)
  resource_id = element(local.ALL_INSTANCE_IDS, count.index)
  key         = "Name"
  value       = "${var.COMPONENT}-${var.ENV}"
}
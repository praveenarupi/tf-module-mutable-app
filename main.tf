resource "aws_instance" "ondemand" {
  count = var.INSTANCES["ONDEMAND"].instance_count
  instance_type = var.INSTANCES["ONDEMAND"].instance_type
  ami = data.aws_ami.ami.image_id
}

resource "aws_spot_instance_request" "spot" {
  count = var.INSTANCES["SPOT"].instance_count
  instance_type = var.INSTANCES["SPOT"].instance_type
  ami = data.aws_ami.ami.image_id
  wait_for_fulfillment = true 
}
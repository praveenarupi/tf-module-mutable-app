data "aws_ssm_parameter" "ssh_credentials" {
  name = "ssh.credentials"
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "centos7-devops-practice-with-ansible"
  owners      = ["self"]
}

data "terraform_remote_state" "infra" {
  backend = "s3"

  config {
    bucket = "terraform-b66"
    key    = "mutable/infra/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}
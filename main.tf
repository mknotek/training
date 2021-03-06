#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-e613ac89
#
# Your subnet ID is:
#
#     subnet-67d7090c
#
# Your security group ID is:
#
#     sg-1cbf1176
#
# Your Identity is:
#
#     terraform-training-pigeon
#

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type = "string"
  default = "eu-central-1"
}

variable "num_webs" {
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami           = "ami-e613ac89"
  instance_type = "t2.micro"
  subnet_id     = "subnet-67d7090c"
  count         = "${var.num_webs}"

  vpc_security_group_ids = ["sg-1cbf1176"]

  tags {
    "Identity" = "terraform-training-pigeon"
    "owner"    = "marian knotek"
    "use"      = "test"
    "name"     = "web ${count.index+1} / ${var.num_webs}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

#module "example" {
#  source = "./example-module/"
#  command = "echo 'hello marian'"
#}

terraform {
  backend "atlas" {
    name = "mknotek/training"
}
}

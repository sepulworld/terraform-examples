provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "kafka" {
  most_recent = true
  filter {
    name = "kafka"
  }
  owners = ["self"]
}

resource "aws_instance" "kafka" {
  ami = "${data.aws_ami.kafka.id}"
  instance_type = "t2.micro"
  tags {
    Name = "kafka-autozane"
  }
}

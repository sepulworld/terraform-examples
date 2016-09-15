provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "kafka" {
  most_recent = true

  filter {
    name   = "name"
    values = ["kafka-*"]
  }

  owners = ["self"]
}

resource "aws_instance" "kafka" {
  ami           = "${data.aws_ami.kafka.id}"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.kafka_instance_profile.name}"
  key_name = "autozane"
  tags {
    Name = "kafka-autozane"
  }
}

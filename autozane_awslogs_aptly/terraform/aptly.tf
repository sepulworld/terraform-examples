provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "aptly" {
  most_recent = true

  filter {
    name   = "name"
    values = ["aptly-*"]
  }

  owners = ["self"]
}

resource "aws_instance" "aptly" {
  ami           = "${data.aws_ami.aptly.id}"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.aptly_instance_profile.name}"
  key_name = "autozane"
  tags {
    Name = "aptly-autozane"
  }
}

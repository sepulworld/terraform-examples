module "asg" {
    source              = "github.com/sepulworld/tf_asg.git?ref=v0.0.3"
    name                = "truami"
    vpc_zone_subnets    = "subnet-f05fdda8,subnet-2b82b64f,subnet-fc703f8a"
    security_group      = "${aws_security_group.allow_truami.id}"
    instance_profile    = "${aws_iam_instance_profile.truami_app_profile.name}"
    instance_type       = "t2.micro"
    ami                 = "${data.aws_ami.truami.id}"
    key_name            = "autozane"
    user_data           = "userdata.sh"
    asg_min_instances   = "1"
    asg_max_instances   = "2"
    health_check_type   = "ELB"
    load_balancer_names = "${module.elb.elb_name}"
    availability_zones  = "us-west-2a,us-west-2b,us-west-2c"
    environment         = "dev"
    team                = "autozane"
}

data "aws_ami" "truami" {  
  most_recent = true

  filter {
    name   = "name"
    values = ["truami-app-*"]
  }

  owners = ["self"]
}

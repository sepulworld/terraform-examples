module "asg" {
    source              = "github.com/sepulworld/tf_asg.git?ref=v0.0.2"
    name                = "myasg"
    vpc_zone_subnets    = "subnet-f05fdda8,subnet-2b82b64f,subnet-fc703f8a"
    security_groups     = "{aws_security_group.allow_goapp.id}"
    instance_type       = "t2.micro"
    ami                 = "${data.aws_ami.goapp.id}"
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

data "aws_ami" "goapp" {  
  most_recent = true

  filter {
    name   = "name"
    values = ["go-hostname-app-*"]
  }

  owners = ["self"]
}

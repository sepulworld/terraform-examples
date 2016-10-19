module "elb" {
    source            = "github.com/sepulworld/tf_elb.git?ref=v0.0.1"
    name              = "myelb-goapp"
    subnet_ids        = "subnet-f05fdda8,subnet-2b82b64f,subnet-fc703f8a"
    security_groups   = "${aws_security_group.allow_goapp.id}"
    port              = "8000"
    health_check_port = "8000"
    health_check_url  = "HTTP:8000/"
}

output "elb_dns_name" {
  value = "${module.elb.elb_dns_name}"
}

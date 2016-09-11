resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "dedicated"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "autozane.co"
  }
}

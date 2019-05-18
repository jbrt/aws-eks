provider "aws" {
  region  = "${var.region}"
  version = "2.10.0"
}

terraform {
  required_version = "<= 0.11.13"
}

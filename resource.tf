variable "ami" {
  type        = map(any)
  description = "AMI values"
  default = {
    "us-east-1" : "ami-1234567890"
    "us-west-1" : "ami-0987654321"
  }

}

variable "region" {
  type = string
  validation {
    condition     = contains(["us-east-1", "us-west-1"], var.region)
    error_message = "do not support other value than us-east-1 and us-west-1"
  }
}


variable "environment" {
  type    = string
  default = "test"
  validation {
    condition     = contains(["prod", "test"], var.environment)
    error_message = "environment should be test or prod"
  }

}


resource "aws_instance" "terraform-instance" {
  #   ami           = var.ami["${var.region}"]
  #   ami           = lookup(var.ami, var.region, "default-ami")
  ami           = try(var.ami[var.region], "ami-default")
  instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
}

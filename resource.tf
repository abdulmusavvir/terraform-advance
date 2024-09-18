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

variable "server-name-and-count" {
  type    = set(any)
  default = ["test", "prod"]
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
  # here we can use count meta argument also instead of for_each if we want to create 2 instance count = 2
  for_each      = var.server-name-and-count
  ami           = try(var.ami[var.region], "ami-default")
  instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
  tags = {
    # agar test environment ho toh test ke 2 server banege else prod ke 2 server banege
    # name = var.environment == "prod" ? "webserver-prod" : "webserver-test"
    # agar 2 server banana hai jo hum ne server-name-and-count mei dala hai then use following code
    name = each.key
  }
}

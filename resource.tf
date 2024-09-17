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

}
resource "aws_instance" "terraform-instance" {
  #   ami           = var.ami["${var.region}"]
  #   ami           = lookup(var.ami, var.region, "default-ami")
  ami           = try(var.ami[var.region], "ami-default")
  instance_type = "t2.micro"
}

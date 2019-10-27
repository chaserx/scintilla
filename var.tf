variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}
variable "availability_zone" {
  description = "availability zone to create subnet"
  default     = "us-east-2a"
}
variable "public_key_path" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}
variable "instance_ami" {
  description = "Ubuntu 18.04 with Docker AMI for AWS EC2 instance"
  default     = "ami-07e2451719af4d446"
}
variable "instance_type" {
  description = "AWS EC2 instance type"
  default     = "t3a.medium"
}
variable "environment_tag" {
  description = "Environment tag"
  default     = "DevBox"
}

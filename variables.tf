

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default = "vpc-2df94b4a"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "proj_prefix" {
  type    = string
  default = "psp"
}

variable "subnets" {
  description = "List of subnets"
  type        = list
  default     = ["subnet-2d7d8d76","subnet-6542ff2c","subnet-79299d1e"]
}

variable "ami" {
  description = "List of subnets"
  type        = string
  default     = "ami-04d5cc9b88f9d1d39"
}




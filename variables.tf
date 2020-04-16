variable "proj" {
  description = "Project Name"
  type        = string
  default = "psp"
}

variable "env" {
  description = "ENVNAME"
  type        = string
  default = "DEV"
}


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

variable "vpc01_subnets" {
  description = "List of subnets"
  type        = list
  default     = ["subnet-2d7d8d76","subnet-6542ff2c","subnet-79299d1e"]
}

variable "ami" {
  description = "List of subnets"
  type        = string
  default     = "ami-04d5cc9b88f9d1d39"
}

variable "cf_bucket_suffix" {
  description = "Name of PSP Bucket"
  type        = string
  default     = "cf"
}


variable "known-sg" {
  type = map(string)

  default = {
    ping_web = "sg-04f49928fcda54d21"
  }
}

variable "required-sg" {
  description = "Required Security Groups"
  type        = list
  default     = ["sg-0d470b6ec28273cae", "sg-01703a732afe10d26"]
}



variable "default-sg" {     
  type = map(string)
  default = {
    mgmt_remote = "sg-0d470b6ec28273cae"
    mgmt_service = "sg-01703a732afe10d26"
  }
}


variable "default_tags" {
    type = map(string)
    default = {
        Project            = "PSP"
        CostCentre         = "55620"
        Tower              = "CCS"
        Owner              = "Mik"
        OS                 = "Linux"
    }
}
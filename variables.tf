
variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
 // default     = "dev"
  default     = "demo"
}

/*variable "aws_accounts" {
  description = "List of AWS accounts to deploy resources"
  type        = map(object({
    profile = string
    region  = string
  }))
  default = {
    dev = {
      profile = "dev"
      region  = "us-east-1"
    }
    demo = {
      profile = "demo"
      region  = "us-east-1"
    }
  }
}*/


variable "vpcs" {
  description = "List of VPC configurations (multiple VPCs support)"
  type = list(object({
    name               = string
    cidr_block         = string
    public_subnets     = list(string)
    private_subnets    = list(string)
    availability_zones = list(string)
  }))
  default = [
    {
      name               = "MainVPC"
      cidr_block         = "10.0.0.0/16"
      public_subnets     = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
      private_subnets    = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
      availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
    },
    /*{
      name               = "SecondaryVPC"
      cidr_block         = "10.1.0.0/16"
      public_subnets     = ["10.1.1.0/24", "10.1.3.0/24", "10.1.5.0/24"]
      private_subnets    = ["10.1.2.0/24", "10.1.4.0/24", "10.1.6.0/24"]
      availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
    }*/
  ]
}



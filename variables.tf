variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  default     = "dev"
  //default     = "demo"
}

variable "custom_ami_id" {
  description = "Custom AMI ID for EC2 Instance"
  type        = string
  default     = "ami-0d362e53d202790a0"
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "AWS Key Pair Name for SSH access"
  type        = string
  default     = "terraform-key"
}


variable "vpc_cidr" {
  description = "cidr"
  type        = string
  default     = "10.0.0.0/16"

}
variable "app_port" {
  description = "Port on which the application runs"
  type        = number
  default     = 8080 # ✅ Change this if your app runs on a different port
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
    name            = string
    cidr_block      = string
    public_subnets  = list(string)
    private_subnets = list(string)
  }))
  default = [
    {
      name            = "MainVPC"
      cidr_block      = "10.0.0.0/16"
      public_subnets  = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
      private_subnets = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
    },
    /*{
    name            = "SecondaryVPC"
    cidr_block      = "10.2.0.0/16" 
    public_subnets  = ["10.2.1.0/24", "10.2.3.0/24", "10.2.5.0/24"]
    private_subnets = ["10.2.2.0/24", "10.2.4.0/24", "10.2.6.0/24"]
  },
  {
    name            = "3rdVPC"
    cidr_block      = "10.3.0.0/16"  
    public_subnets  = ["10.3.1.0/24", "10.3.3.0/24", "10.3.5.0/24"]
    private_subnets = ["10.3.2.0/24", "10.3.4.0/24", "10.3.6.0/24"]
  },
  /*{
    name            = "4thVPC"
    cidr_block      = "10.4.0.0/16"  
    public_subnets  = ["10.4.1.0/24", "10.4.3.0/24", "10.4.5.0/24"]
    private_subnets = ["10.4.2.0/24", "10.4.4.0/24", "10.4.6.0/24"]
  },
  {
    name            = "5thVPC"
    cidr_block      = "10.5.0.0/16"  
    public_subnets  = ["10.5.1.0/24", "10.5.3.0/24", "10.5.5.0/24"]
    private_subnets = ["10.5.2.0/24", "10.5.4.0/24", "10.5.6.0/24"]
  }*/

  ]
}






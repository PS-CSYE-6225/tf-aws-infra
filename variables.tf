variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"

}

variable "custom_ami_id" {
  description = "Custom AMI ID for EC2 Instance"
  type        = string

}

variable "instance_type" {
  description = "Instance Type"
  type        = string

}

variable "key_pair_name" {
  description = "AWS Key Pair Name for SSH access"
  type        = string


}


variable "vpc_cidr" {
  description = "cidr"
  type        = string
  default     = "10.0.0.0/16"

}
variable "app_port" {
  description = "Port on which the application runs"
  type        = number
  default     = 8080
}

variable "db_port" {
  type = number
}

variable "db_family" {
  type = string
}

variable "db_name" {
  type = string

}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string

}
variable "instance_class" {
  type = string
}

variable "db_host" {
  type = string
}


variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "storage_type" {
  type = string
}
variable "identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "route53_zone_id" {
  description = "Zone ID for route 53"
}

variable "domain_name" {
  description = "Domain name"
}

variable "dev_subdomain" {
  description = "dev Domain name"
}

variable "demo_subdomain" {
  description = "Demo Domain name"
}

variable "subdomain" {
  type    = list(string)
  default = ["dev", "demo"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks for the first VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks for the first VPC"
  type        = list(string)
}

variable "second_vpc_cidr" {
  description = "CIDR block for the second VPC"
  type        = string
}

variable "second_public_subnets" {
  description = "List of public subnet CIDR blocks for the second VPC"
  type        = list(string)
}

variable "second_private_subnets" {
  description = "List of private subnet CIDR blocks for the second VPC"
  type        = list(string)
}

variable "network_name" {
  description = "Unique name for this network deployment"
  type        = string
}

variable "vpc_count" {
  description = "Number of VPCs to create"
  type        = number
  default     = 1
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









provider "aws" {
  region  = var.aws_region  
  profile = var.aws_profile 
 }

 /*provider "aws" {
  alias   = "dev"
  region  = var.aws_accounts["dev"].region
  profile = var.aws_accounts["dev"].profile
}

provider "aws" {
  alias   = "demo"
  region  = var.aws_accounts["demo"].region
  profile = var.aws_accounts["demo"].profile
}*/

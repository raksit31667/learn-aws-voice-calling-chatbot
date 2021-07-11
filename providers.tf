terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.49"
    }
  }
}

provider "aws" {
  profile = "raksit31667-terraform"
  region  = "ap-southeast-1"
}

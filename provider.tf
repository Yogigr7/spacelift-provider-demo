terraform {
  required_version = "1.5.6"

  backend "s3" {
    bucket         = "test-rate-platform"
    dynamodb_table = "terraform-state-lock-test-platform"
    key            = "spacelift-poc-demo-profile-provider/testing-spacelift-provider.tfstate"
    region         = "us-east-1"
    # role_arn       = "arn:aws:iam::459772859073:role/test-platform-state-role"
    # profile        = "test-platform-JuniorCPE"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

# provider "aws" {
#   region  = "us-east-1"
# #   assume_role {
# #     role_arn = "arn:aws:iam::459772859073:role/SpaceliftExecRole"
# #   }
# }

provider "aws" {
  region  = "us-east-1"
}

provider "aws" {
  alias   = "nonprod"
  region  = "us-east-1"
  assume_role {
     role_arn = "arn:aws:iam::420127996065:role/SpaceliftExecRole"
  }
}
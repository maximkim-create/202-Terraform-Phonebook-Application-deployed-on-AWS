terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.10.1"
    }
  }
}

provider "github" {
  token = "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"
}
provider "aws" {
  region = "us-east-1"
}
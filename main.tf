terraform {
  required_version = ">=1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "s3" {
    bucket = "bucket-pedrovargas"
    region = "us-east-1"
    key    = "Pip-Aws/state.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"

}

module "waf" {
  source = "./modules"
  scope  = "CLOUDFRONT"
}

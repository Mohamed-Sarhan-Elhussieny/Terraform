# ************************ aws provider ************************
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 6.0"
#     }
#   }
# }

# # Configure the AWS Provider
# provider "aws" {
#   region = "us-east-1"
# }

# ************************ google provider ************************
# provider "google" {
#   project     = "my-project-id"
#   region      = "us-central1"
# }

# ************************ azure provider ************************
# Azure Provider source and version being used
# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=5.0.0"
#     }
#   }
# }

# # Configure the Microsoft Azure Provider
# provider "azurerm" {
#   features {}
# }



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  # Don't try to validate these fake credentials against real AWS
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Send AWS API calls to LocalStack
  endpoints {
    s3  = "http://localhost:4566"
    sts = "http://localhost:4566"
  }

  s3_use_path_style = true
}

module "network" {
  source = "./network"

  vpc_cidr_block             = var.vpc_cidr_block
  region                     = var.region
  subnet_private1_cidr_block = var.subnet_private1_cidr_block
  subnet_private2_cidr_block = var.subnet_private2_cidr_block
  subnet_public1_cidr_block  = var.subnet_public1_cidr_block
  subnet_public2_cidr_block  = var.subnet_public2_cidr_block
  subnet_public3_cidr_block  = var.subnet_public3_cidr_block
  map_public_ip_on_launch    = var.map_public_ip_on_launch
  ip_allow_ssh               = var.ip_allow_ssh
  port_allow                 = var.port_allow
  port_allow_egress          = var.port_allow_egress
}


module "resouce" {
  source = "./resouce"

  public_subnet_ids = module.network.public_subnet_ids
}
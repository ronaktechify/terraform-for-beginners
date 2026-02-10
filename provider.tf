# Terraform block is used to configure Terraform itself
# It defines which providers are required and their versions
terraform {

  # required_providers tells Terraform which cloud provider plugins to use
  required_providers {

    # aws is the provider name used in our code
    aws = {

      # source defines where Terraform should download the provider from
      # hashicorp/aws is the official AWS provider
      source = "hashicorp/aws"

      # version locks the provider version
      # This ensures consistent behavior across all machines
      version = "6.31.0"
    }
  }
}

# Provider block configures the AWS provider
# It tells Terraform HOW and WHERE to connect to AWS
provider "aws" {

  # Region where all AWS resources will be created
  # Example: us-east-1 (N. Virginia)
  region = "us-east-1"
}

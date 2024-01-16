# root/providers.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.10.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "aws" {
  region = var.aws_region
}
terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.11.0"
    }

    fly = {
      source = "fly-apps/fly"
      version = "0.0.23"
    }

    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "mongodbatlas" {
    private_key = var.atlas_prv_key
    public_key  = var.atlas_pub_key
}


provider "fly" {
    fly_api_token = var.flyio_token
}


terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.11.0"
    }
  }
}

provider "mongodbatlas" {
    private_key = var.atlas_prv_key
    public_key  = var.atlas_pub_key
}
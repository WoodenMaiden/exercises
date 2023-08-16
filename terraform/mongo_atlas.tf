resource "mongodbatlas_project" "atlas-project" {
    name   = "TP-terraform"
    org_id = var.atlas_org_id

    limits {
        name  = "atlas.project.deployment.clusters"
        value = 1
    }
}

resource "mongodbatlas_database_user" "user" {
    username           = "api"
    password           = random_password.user_password.result 

    project_id         = mongodbatlas_project.atlas-project.id
    auth_database_name = "admin"

    roles {
        role_name     = "readWrite"
        database_name = "shop"
    }
}

resource "mongodbatlas_advanced_cluster" "shop" {
    project_id   = mongodbatlas_project.atlas-project.id
    name         = "shop-cluster"

    cluster_type = "REPLICASET"

    replication_specs {
        region_configs {
            electable_specs {
                instance_size = "M0"
            }

            provider_name         = "TENANT"
            backing_provider_name = "AWS"
            region_name           = "AP_SOUTHEAST_1"
            priority              = 7 
        }
    }
}

resource "mongodbatlas_project_ip_access_list" "ip-whitelist" {
    project_id = mongodbatlas_project.atlas-project.id
    cidr_block = "0.0.0.0/0"
    comment    = "A really secure IP address whitelist :^)"
}

resource "random_password" "user_password" {
    length  = 20
    special = false // because it will appear on a URL so we don't want special characters
}
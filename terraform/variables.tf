variable "atlas_pub_key" {
    nullable    = false
    type        = string
    description = "Public key for Atlas"
}

variable "atlas_prv_key" {
    nullable    = false
    type        = string
    description = "Private key for Atlas"
}

variable "atlas_org_id" {
    nullable    = false
    type        = string
    description = "Organization ID for Atlas"
}
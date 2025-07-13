variable "purview_name" {
  type = string
}

variable "mir_name" {
  type = string
}

variable "mir_description" {
  type = string
  default = "created by terraform"
}

variable "arm_tenant_id" {
  type = string
}

variable "arm_client_id" {
  type = string
}

variable "arm_client_secret" {
  type = string
}

variable "purview_id" {
  type = string
}

variable "ir_name" {
  type    = string
  default = "managed-ir"
}

variable "mir_description" {
  type    = string
  default = "created by terraform"
}

variable "kind" {
  type    = string
  default = "Managed"
}
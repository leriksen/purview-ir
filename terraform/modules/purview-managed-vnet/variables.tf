variable "purview_name" {
  type = string
}

variable "purview_mvnet_name" {
  type = string
  default = "defaultv2"
}

variable create_duration {
  type    = string
  default = "120s"
}
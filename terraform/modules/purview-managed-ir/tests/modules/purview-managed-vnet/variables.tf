variable "purview_name" {
  type = string
}

variable "purview_mvnet_name" {
  type = string
}

variable create_delay {
  type    = string
  default = "120s"
}
resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = false
  numeric = false
  special = false
}
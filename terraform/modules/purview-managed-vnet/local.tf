locals {
  purview_endpoint = trimprefix(var.purview_name, "https://")
}
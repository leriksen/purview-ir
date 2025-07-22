locals {
  purview_endpoint = trimprefix(module.purview_account.scan_endpoint, "https://")
}
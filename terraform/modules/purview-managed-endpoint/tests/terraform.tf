terraform {
  required_version = "~>1.10.0"
  required_providers {}

  backend "local" {
    path = "./terraform.tfstate"
  }
}

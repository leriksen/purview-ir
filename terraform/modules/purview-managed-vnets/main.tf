data external "mvnets" {
  program = [
    "bash",
    "${path.module}/script.sh"
  ]

  query = {
    arm_tenant_id     = var.arm_tenant_id
    arm_client_id     = var.arm_client_id
    arm_client_secret = var.arm_client_secret
    purview_name      = var.purview_name
  }
}

# resource terraform_data "mvnets" {
#   provisioner "local-exec" {
#     interpreter = ["bash", "-c"]
#     working_dir = path.module
#
#     environment = {
#       ARM_TENANT_ID      = var.arm_tenant_id
#       ARM_CLIENT_ID      = var.arm_client_id
#       ARM_CLIENT_SECRET  = var.arm_client_secret
#       PVIEW_ACCOUNT_NAME = var.purview_name
#     }
#
#     command = <<-EOF
#       set -euo pipefail
#
#       test -n "$${ARM_TENANT_ID}"
#       test -n "$${ARM_CLIENT_ID}"
#       test -n "$${ARM_CLIENT_SECRET}"
#       test -n "$${PVIEW_ACCOUNT_NAME}"
#
#       API_VERSION="2023-09-01"
#
#       # get bearer token
#       AUTH_RESPONSE="$(curl -s -X POST          \
#         -d "client_id=$${ARM_CLIENT_ID}"         \
#         -d "client_secret=$${ARM_CLIENT_SECRET}" \
#         -d "grant_type=client_credentials"      \
#         -d "resource=https://purview.azure.net" \
#         "https://login.microsoftonline.com/$${ARM_TENANT_ID}/oauth2/token")"
#
#       ERROR="$(echo $${AUTH_RESPONSE} | jq .error)"
#
#       if [[ "$${ERROR}" != "null" ]]; then
#         echo "Error obtaining access token."
#         echo "$${AUTH_RESPONSE}" | jq .
#         exit 1
#       fi
#
#       TOKEN="$(echo $${AUTH_RESPONSE} | jq -r .access_token)"
#
#       # get list of Managed VNETS
#
#       MVNET_URL="https://$${PVIEW_ACCOUNT_NAME}.purview.azure.com/scan/managedvirtualnetworks?api-version=$${API_VERSION}"
#
#       RESULT="$(curl --request GET "$${MVNET_URL}"   \
#         --header "Authorization: Bearer $${TOKEN}" \
#         --header "Content-Type: application/json" \
#       )"
#
#       ERROR="$(echo $${RESULT} | jq .error)"
#
#       if [[ "$${ERROR}" != "null" ]]; then
#         echo "Error getting list of MVNETS."
#         echo "$${RESULT}" | jq .
#         exit 1
#       fi
#
#       echo "$${RESULT}" | jq --compact-output --monochrome-output .value
#
#       exit 0
#     EOF
#   }
# }
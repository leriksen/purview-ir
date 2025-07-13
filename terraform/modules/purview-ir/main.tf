resource null_resource "mir_creation" {
  triggers = {
    purview_account_name = var.purview_name
  }

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    working_dir = path.module

    environment = {
      ARM_TENANT_ID      = var.arm_tenant_id
      ARM_CLIENT_ID      = var.arm_client_id
      ARM_CLIENT_SECRET  = var.arm_client_secret
      PVIEW_ACCOUNT_NAME = var.purview_name
      MIR_NAME           = var.mir_name
      MIR_DESCRIPTION    = var.mir_description
    }

    command = <<-EOF
      set -euo pipefail

      test -n "${ARM_TENANT_ID}"
      test -n "${ARM_CLIENT_ID}"
      test -n "${ARM_CLIENT_SECRET}"
      test -n "${PVIEW_ACCOUNT_NAME}"
      test -n "${MIR_NAME}"
      test -n "${MIR_DESCRIPTION}"

      API_VERSION="2023-09-01"

      # get bearer token
      AUTH_RESPONSE="$(curl -s -X POST          \
        -d "client_id=${ARM_CLIENT_ID}"         \
        -d "client_secret=${ARM_CLIENT_SECRET}" \
        -d "grant_type=client_credentials"      \
        -d "resource=https://purview.azure.net" \
        "https://login.microsoftonline.com/${ARM_TENANT_ID}/oauth2/token")"

      ERROR="$(echo ${AUTH_RESPONSE} | jq .error)"

      if [[ ${ERROR} != "null" ]]; then
        echo "Error obtaining access token."
        echo "${AUTH_RESPONSE}" | jq .
        exit 1
      fi

      TOKEN="$(echo ${AUTH_RESPONSE} | jq -r .access_token)"

      # create Managed Integration Runtime
      MIR_BODY=$( jq -n '{ kind: "Managed" }' )

      MIR_URL="https://${PVIEW_ACCOUNT_NAME}.purview.azure.com/scan/integrationruntimes/${MIR_NAME}?api-version=${API_VERSION}"

      RESULT="$(curl --request PUT "${MIR_URL}"   \
        --header "Authorization: Bearer ${TOKEN}" \
        --header "Content-Type: application/json" \
        --data "${MIR_BODY}"                      \
      )"

      ERROR="$(echo ${RESULT} | jq .error)"

      if [[ ${ERROR} != "null" ]]; then
        echo "Error creating MIR."
        echo "${RESULT}" | jq .
        exit 1
      fi

      exit 0
    EOF
  }
}
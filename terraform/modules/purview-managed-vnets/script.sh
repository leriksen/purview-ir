#!/usr/bin/env bash

set -euo pipefail

eval "$(jq -r '@sh "TENANT_ID=\(.arm_tenant_id) CLIENT_ID=\(.arm_client_id) CLIENT_SECRET=\(.arm_client_secret) PURVIEW_NAME=\(.purview_name)"')"

test -n "${TENANT_ID}"
test -n "${CLIENT_ID}"
test -n "${CLIENT_SECRET}"
test -n "${PURVIEW_NAME}"

API_VERSION="2023-09-01"

# get bearer token
AUTH_RESPONSE="$(curl --silent --request POST   \
  -d "client_id=${CLIENT_ID}"         \
  -d "client_secret=${CLIENT_SECRET}" \
  -d "grant_type=client_credentials"      \
  -d "resource=https://purview.azure.net" \
  "https://login.microsoftonline.com/${TENANT_ID}/oauth2/token")"

ERROR="$(echo ${AUTH_RESPONSE} | jq .error)"

if [[ ${ERROR} != "null" ]]; then
  echo "Error obtaining access token."
  echo "${AUTH_RESPONSE}" | jq .
  exit 1
fi

TOKEN="$(echo ${AUTH_RESPONSE} | jq -r .access_token)"

# get list of Managed VNETS

MVNET_URL="https://${PURVIEW_NAME}.purview.azure.com/scan/managedvirtualnetworks?api-version=${API_VERSION}"

RESULT="$(curl --silent --request GET "${MVNET_URL}"   \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/json" \
)"

ERROR="$(echo "${RESULT}" | jq .error)"

if [[ ${ERROR} != "null" ]]; then
  echo "Error getting list of MVNETS."
  echo "${RESULT}" | jq .
  exit 1
fi

echo "${RESULT}" | jq --compact-output --monochrome-output '{"id": .value[0].id, "name": .value[0].name}'

exit 0

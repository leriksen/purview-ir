set -euo pipefail

PAYLOAD="$(jq --null-input --arg objectid "${OBJECTID}" '. + {"objectid": $objectid} ')"


: "${ARM_CLIENT_ID:?ARM_CLIENT_ID is not set}"
: "${ARM_CLIENT_SECRET:?ARM_CLIENT_SECRET is not set}"
: "${ARM_TENANT_ID:?ARM_TENANT_ID is not set}"

echo "ARM_CLIENT_ID       == ${ARM_CLIENT_ID}"
echo "ARM_TENANT_ID       == ${ARM_TENANT_ID}"
echo "RG                  == ${RG}"
echo "ARM_SUBSCRIPTION_ID == ${ARM_SUBSCRIPTION_ID}"
echo "PVIEW_ACCOUNT       == ${PVIEW_ACCOUNT}"

RESPONSE=$(curl -s -X POST \
  "https://login.microsoftonline.com/${ARM_TENANT_ID}/oauth2/v2.0/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials" \
  -d "client_id=${ARM_CLIENT_ID}" \
  -d "client_secret=${ARM_CLIENT_SECRET}" \
  -d "scope=https://management.azure.com/.default")

BEARER=$(echo "$RESPONSE" | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)

if [ -z "$BEARER" ]; then
  echo "Failed to retrieve token. Response:"
  echo "$RESPONSE"
  exit 1
fi

RESULT="$(
  curl -s -X POST \
  --header "Authorization: Bearer ${BEARER}" \
  --header "Content-Type: application/json"  \
  --data "${PAYLOAD}"                        \
  "https://management.azure.com/subscriptions/${ARM_SUBSCRIPTION_ID}/resourceGroups/${RG}/providers/Microsoft.Purview/accounts/${PVIEW_ACCOUNT}/addRootCollectionAdmin?api-version=2021-07-01"
)"

ERROR="$(echo ${RESULT} | jq '.error')"

if [ ! -z "${ERROR}" ]; then
  echo "Error retrieving bearer token";
  echo "${ERROR}" | jq '.';
  exit 1;
fi

echo "RESULT = $(echo ${RESULT} | jq '.')"

exit 0

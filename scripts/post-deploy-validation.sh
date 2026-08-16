#!/usr/bin/env bash
set -euo pipefail

: "${RESOURCE_GROUP:?RESOURCE_GROUP must be set}"

echo "Validating Azure deployment in resource group: ${RESOURCE_GROUP}"

if ! az group show --name "${RESOURCE_GROUP}" --output none; then
  echo "Resource group ${RESOURCE_GROUP} was not found."
  exit 1
fi

storage_count=$(az storage account list \
  --resource-group "${RESOURCE_GROUP}" \
  --query "length(@)" \
  --output tsv)

if [[ "${storage_count}" -lt 1 ]]; then
  echo "Expected at least one storage account in ${RESOURCE_GROUP}."
  exit 1
fi

insecure_tls_count=$(az storage account list \
  --resource-group "${RESOURCE_GROUP}" \
  --query "[?minimumTlsVersion!='TLS1_2'] | length(@)" \
  --output tsv)

if [[ "${insecure_tls_count}" -ne 0 ]]; then
  echo "One or more storage accounts do not enforce TLS 1.2."
  exit 1
fi

echo "Post-deployment validation passed."

#!/bin/bash
#
# Identify Subaccounts with SAML IdPs
#
btp --format json list accounts/subaccount > output/subaccounts.json
# Get the subaccount id using jq and loop through the subaccounts

cat output/subaccounts.json | jq -r '.value[] | .guid, .subdomain' | while IFS=, read -r subaccount; do
  read subdomain
  # echo "Subaccount: $subaccount, subdomain: $subdomain"
  btp --format json list security/trust -sa $subaccount > output/trust.json
  cat output/trust.json | jq -r '.[] | .originKey, .protocol' | while read -r originKey; do
    read protocol
    # When protocol is SAML, then print the Subaccount / Origin Details
    if [ "$protocol" == "SAML" ]; then
      echo "subdomain: $subdomain"
      echo "originKey: $originKey"
    fi
  done
done

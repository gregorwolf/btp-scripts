#!/bin/bash
#
# Read authorizations of all Users in all Subaccounts
#
btp --format json list accounts/subaccount > output/subaccounts.json
# Get the subaccount id using jq and loop through the subaccounts

echo "displayName;subdomain;username;roleCollection"
cat output/subaccounts.json | jq -r '.value[] | .guid, .subdomain, .displayName' | while IFS=, read -r subaccount; do
  read subdomain
  read displayName
  #echo "Subaccount: $subaccount, subdomain: $subdomain"
  btp --format json list security/user -sa $subaccount > output/users.json
  cat output/users.json | jq -r '.[]' | while read -r username; do
    #echo "username: $username"
    btp --format json get security/user $username -sa $subaccount > output/authorizations.json
    cat output/authorizations.json | jq -r '.roleCollections.[]' | while read -r roleCollection; do
      # echo "roleCollection: $roleCollection"
      echo "$displayName;$subdomain;$username;$roleCollection"
    done
  done
done

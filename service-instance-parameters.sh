#!/bin/bash
#
# Read parameters of all service instances in all Subaccounts
#
btp --format json list accounts/subaccount > output/subaccounts.json
# Get the subaccount id using jq and loop through the subaccounts

echo "displayName;subdomain;username;roleCollection"
cat output/subaccounts.json | jq -r '.value[] | .guid, .subdomain, .displayName' | while IFS=, read -r subaccount; do
  read subdomain
  read displayName
  echo "Subaccount: $subaccount, subdomain: $subdomain"
  # Create a directory for the subaccount
  mkdir -p output/$subdomain
  btp --format json list services/instance --subaccount $subaccount > output/$subdomain/service-instances.json
  cat output/$subdomain/service-instances.json | jq -r '.[] | .id, .name' |  while IFS=, read -r id; do
  read name
    echo "id: $id, name: $name"
    # Create a directory for the service instance
    mkdir -p output/$subdomain/$name
    # Get the service instance parameters
    btp --format json get services/instance $id --subaccount $subaccount --show-parameters true > output/$subdomain/$name/service-instance.json
  done
done

# Cloudflare DNS update script

## Environment variables

    # CF access token
    AUTH_TOKEN=<your access token>
    # CF zone id
    ZONE_ID=<your zone id>
    # (Sub)domain record id
    RECORD_ID=<your record id>
    # (Sub)domain name
    RECORD_NAME=home.example.com
    # Enable dumping request and response payload
    DEBUG=true

## How to get the record details

    #!/bin/bash

    $zone_id=<your zone id>
    $auth_token=<your access token>

    curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records" -H "Authorization: Bearer $auth_token" -H "Content-Type: application/json"

Beautify the response payload and look for the specific record id.

## Helm

Copy and update the file `helm/secrets-home-example-com.yaml` to your needs.

    # Create the secrets
    kubectl apply -f helm/secrets-home-your-domain.yaml

    # Install crobjob with helm
    helm install update-dns-home-your-domain update-dns --set secretName=home-your-domain-secret

Be aware that all script create the kubes components in namespace `jobs`. Update if needed.

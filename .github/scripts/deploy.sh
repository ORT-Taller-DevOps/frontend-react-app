#!/bin/bash

cd dist/apps/catalog
echo "Deploying site to $1"
aws s3 sync ./ s3://$1 --metadata-directive 'REPLACE' --cache-control no-cache,no-store,must-revalidate --delete

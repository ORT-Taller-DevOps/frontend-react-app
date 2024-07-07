#!/bin/bash

cd dist/apps/catalog

echo "Removing existing files in $1"
aws s3 rm s3://$1 --recursive

echo "Uploading files to $1"
aws s3 sync ./ s3://$1 --metadata-directive 'REPLACE' --cache-control no-cache,no-store,must-revalidate --delete

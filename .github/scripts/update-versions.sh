#!/bin/sh

set -ae

cd "$(dirname "$0")/../.."

getLatestReleaseTag() {
  echo "Checking latest release version for $1..." > /dev/stderr
  gh release view --repo "$1" --json tagName --template '{{.tagName}}'
}

IAITO_VERSION=$(getLatestReleaseTag radareorg/iaito)

echo "Updating versions in snap/snapcraft.yaml..." > /dev/stderr
yq eval -i '.parts.iaito.source-tag=strenv(IAITO_VERSION)' snap/snapcraft.yaml

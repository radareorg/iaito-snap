#!/bin/sh

set -ae

cd "$(dirname "$0")/../.."

getLatestReleaseTag() {
  echo "Checking latest release version for $1..." > /dev/stderr
  gh release view --repo "$1" --json tagName --template '{{.tagName}}'
}

IAITO_VERSION=$(getLatestReleaseTag radareorg/iaito)
TRANSLATIONS_VERSION=$(getLatestReleaseTag radareorg/iaito-translations)

echo "Updating versions in snap/snapcraft.yaml..." > /dev/stderr
yq eval -i '.parts.iaito.source-tag=strenv(IAITO_VERSION) | 
  .parts.iaito-translations.source-tag=strenv(TRANSLATIONS_VERSION)
  ' snap/snapcraft.yaml

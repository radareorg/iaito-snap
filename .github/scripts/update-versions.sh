#!/bin/sh

set -ae

cd "$(dirname "$0")/../.."

getLatestReleaseTag() {
  echo "Checking latest release version for $1..." > /dev/stderr
  gh release view --repo "$1" --json tagName --template '{{.tagName}}'
}

IAITO_VERSION=$(getLatestReleaseTag radareorg/iaito)
R2_VERSION=$(getLatestReleaseTag radareorg/radare2)
R2GHIDRA_VERSION=$(getLatestReleaseTag radareorg/r2ghidra)
R2FRIDA_VERSION=$(getLatestReleaseTag nowsecure/r2frida)
R2DEC_VERSION=$(getLatestReleaseTag wargio/r2dec-js)
YARA_VERSION=$(getLatestReleaseTag VirusTotal/yara)
R2YARA_VERSION=$(getLatestReleaseTag radareorg/r2yara)

echo "Updating versions in snap/snapcraft.yaml..." > /dev/stderr
yq eval -i '.parts.iaito.source-tag=strenv(IAITO_VERSION) |
  .parts.radare2.source-tag=strenv(R2_VERSION) | 
  .parts.r2ghidra.source-tag=strenv(R2GHIDRA_VERSION) |
  .parts.r2frida.source-tag=strenv(R2FRIDA_VERSION) |
  .parts.r2dec.source-tag=strenv(R2DEC_VERSION) |
  .parts.yara.source-tag=strenv(YARA_VERSION) |
  .parts.r2yara.source-tag=strenv(R2YARA_VERSION)
  ' snap/snapcraft.yaml

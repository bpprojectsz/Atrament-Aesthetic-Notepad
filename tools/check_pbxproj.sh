#!/usr/bin/env bash
set -e
PBX=app/ios/Runner.xcodeproj/project.pbxproj
if grep -q 'ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = AppIcon' "$PBX"; then
  echo "ERROR: pbxproj contains AppIcon in ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS"
  echo "Expected YES or NO. Revert with: git checkout -- $PBX"
  exit 1
fi
echo "pbxproj OK"

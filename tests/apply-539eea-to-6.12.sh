#!/bin/bash

set -eou pipefail

# Directory containing the Linux kernel source
LINUX_DIR="./linux"
# Directory containing the patches
PATCHES_DIR="../pp/linux-t2-patches-539eea1f9127f1623794ee8c7ccc37e8b00f60a3"

# Change to the Linux directory
cd "${LINUX_DIR}"

# Apply all patches except the problematic ones
while IFS= read -r patch_file; do
  base_name=$(basename "$patch_file")
  
  if [[ "$base_name" == "1002-Put-apple-bce-in-drivers-staging.patch" || 
  "$base_name" == "1005-HID-hid-appletb-bl-add-driver-for-the-backlight-of-A.patch" || 
  "$base_name" == "1006-HID-hid-appletb-kbd-add-driver-for-the-keyboard-mode.patch" ]]; then
    echo "Skipping ${patch_file}"
    continue
  fi
  
  echo "Applying ${patch_file}"
  patch -p1 < "${patch_file}"
done < <(find "${PATCHES_DIR}" -type f -name "*.patch" | sort)

echo "Patching complete"

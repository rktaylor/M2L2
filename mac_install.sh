#!/bin/bash

# Strict mode: exit on error, exit on unset variable, pipefail
set -euo pipefail

echo "🚀 Installing Distrobox on macOS with full Podman support..."

# 1. Check for Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew is not installed. Please install it first: https://brew.sh"
  exit 1
fi
echo "✅ Homebrew found."

# 2. Install Podman if not present
if ! command -v podman >/dev/null 2>&1; then
  echo "📦 Podman not found. Installing via Homebrew..."
  brew install podman
else
  echo "✅ Podman is already installed."
fi

# 3. Initialize and start the Podman machine if not running
# Check if a machine exists and is running
machine_status=$(podman machine list --format "{{.Running}}" --noheading)
if [[ "$machine_status" != "true" ]]; then
  echo "⚙️ Podman machine not running. Initializing and starting..."
  # Initialize only if no machine exists (avoids error if already initialized)
  if ! podman machine list --format "{{.Name}}" --noheading | grep -q .; then
     echo "🔧 Initializing Podman machine (this might take a few minutes)..."
     podman machine init
  fi
  echo "🏁 Starting Podman machine..."
  podman machine start
else
  echo "✅ Podman machine is already running."
fi

# Define target directory for binaries
TARGET_DIR="/usr/local/bin"
echo "ℹ️  Binaries will be installed to $TARGET_DIR"

# Create target directory if it doesn't exist (less common on macOS, but safe)
sudo mkdir -p "$TARGET_DIR"

# 4. Download Distrobox binaries to macOS $TARGET_DIR
echo "📥 Downloading Distrobox binaries to $TARGET_DIR..."
DISTROBOX_BASE_URL="https://raw.githubusercontent.com/89luca89/distrobox/main"
BINARIES=(
    "distrobox"
    "distrobox-init"
    "distrobox-host-exec"
    "distrobox-export"
    "distrobox-create"
    "distrobox-enter"
    "distrobox-list"
    "distrobox-rm"
    "distrobox-stop"
) # Use distrobox-host-exec instead of .in

for bin_name in "${BINARIES[@]}"; do
  target_path="$TARGET_DIR/$bin_name"
  source_url="$DISTROBOX_BASE_URL/$bin_name"
  echo "   Downloading $bin_name..."
  # Use curl with -fL to follow redirects and fail on server errors
  if sudo curl -fsSL "$source_url" -o "$target_path"; then
     echo "   ✅ Downloaded $bin_name to $target_path"
  else
     echo "   ❌ Failed to download $bin_name from $source_url"
     exit 1
  fi
done

# 5. Grant execution permissions
echo "🔑 Granting execution permissions for Distrobox binaries..."
sudo chmod +x "$TARGET_DIR"/distrobox* # Be specific to avoid changing permissions on unrelated files

# 6. Copy binaries into the Podman VM
echo "📤 Copying binaries into the Podman machine's /usr/local/bin/..."
VM_TARGET_DIR="/usr/local/bin"
for bin_name in "${BINARIES[@]}"; do
  host_path="$TARGET_DIR/$bin_name"
  vm_tmp_path="/tmp/$bin_name"
  vm_final_path="$VM_TARGET_DIR/$bin_name"
  echo "   ➡️ Uploading $bin_name to VM ($vm_final_path)..."

  # Ensure target directory exists and remove old file if present
  if podman machine ssh -- "sudo mkdir -p '$VM_TARGET_DIR' && sudo rm -f '$vm_final_path'"; then
      # Copy using ssh and cat redirection
      if podman machine ssh -- "cat > '$vm_tmp_path'" < "$host_path"; then
          # Move to final location and set permissions
          if podman machine ssh -- "sudo mv '$vm_tmp_path' '$vm_final_path' && sudo chmod +x '$vm_final_path'"; then
              echo "   ✅ Copied and set permissions for $bin_name in VM."
          else
              echo "   ❌ Failed to move or set permissions for $bin_name in VM."
              podman machine ssh -- "rm -f '$vm_tmp_path'" # Attempt cleanup
              exit 1
          fi
      else
          echo "   ❌ Failed to upload $bin_name to VM temp location via ssh."
          exit 1
      fi
  else
      echo "   ❌ Failed to prepare target directory or remove existing file in VM."
      exit 1
  fi
done


echo "" # Newline for readability
echo "✅ Installation complete!"
echo "🎉 You can now create your first container with:"
echo "   distrobox create --name my-distro --image ubuntu:latest"
echo ""
echo "   Then enter it using:"
echo "   distrobox enter my-distro"
echo ""
echo "   To list your containers:"
echo "   distrobox list"
echo ""
echo "Happy Distroboxing! 📦"

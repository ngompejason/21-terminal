#!/bin/bash


# Function to install a package
install_package() {
    if ! command -v $1 &> /dev/null
    then
        echo "$1 is not installed. Attempting to install it..."
        sudo apt-get update && sudo apt-get install -y $1
        if [ $? -ne 0 ]; then
            echo "Failed to install $1. Please install it manually and run this script again."
            exit 1
        fi
    else
        echo "$1 is already installed."
    fi
}

# Check and install git and make
install_package git
install_package make

# Define the path to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define the name of the Nerd Font directory
NERD_FONT_DIR="0xProto"

# Define the local fonts directory
FONTS_DIR="$HOME/.local/share/fonts"

# Define the config directory
CONFIG_DIR="$HOME/.config"

# Check if the fonts directory already exists, if not, create it
if [ ! -d "$FONTS_DIR" ]; then
    mkdir -p "$FONTS_DIR"
fi

# Check if the Nerd Font directory exists in the script's directory
if [ ! -d "$SCRIPT_DIR/$NERD_FONT_DIR" ]; then
    echo "Error: $NERD_FONT_DIR directory not found in the script's directory."
    exit 1
fi

# Move the Nerd Font directory to the fonts directory
cp -R "$SCRIPT_DIR/$NERD_FONT_DIR" "$FONTS_DIR/"

# Refresh the font cache
fc-cache -fv

echo "Nerd Font installed successfully. You can delete the original $NERD_FONT_DIR directory if desired."

# Get the default profile ID
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

# Change the terminal font to 0xProto
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font '0xProto 12'

# Change the terminal background color
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ background-color 'rgb(9, 12, 12)'

echo "Terminal font changed to 0xProto and background color updated. You may need to restart your terminal for changes to take effect."

# Copy starship.toml to ~/.config
if [ -f "$SCRIPT_DIR/starship.toml" ]; then
    # Create ~/.config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"
    
    # Copy the file
    cp "$SCRIPT_DIR/starship.toml" "$CONFIG_DIR/"
    echo "starship.toml copied to $CONFIG_DIR/"
else
    echo "Warning: starship.toml not found in the script's directory."
fi

# Install ble.sh
echo "Installing ble.sh..."
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local

# Add ble.sh to .bashrc if not already present
if ! grep -q "source ~/.local/share/blesh/ble.sh" ~/.bashrc; then
    echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc
    echo "ble.sh added to ~/.bashrc"
else
    echo "ble.sh already in ~/.bashrc"
fi

# Cleanup
echo "Cleaning up..."
rm -rf ble.sh

# Source ~/.bashrc (Note: This will only affect the current script execution)
source ~/.bashrc

echo "All installations and configurations complete."
echo "To apply all changes in your current terminal session, please run:"
echo "source ~/.bashrc"
echo "Or simply close this terminal and open a new one."

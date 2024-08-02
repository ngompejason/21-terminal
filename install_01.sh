#!/bin/bash

# Function to install curl
install_curl() {
    echo "curl is not installed. Attempting to install it..."
    sudo apt-get update && sudo apt-get install -y curl
    if [ $? -ne 0 ]; then
        echo "Failed to install curl. Please install it manually and run this script again."
        exit 1
    fi
}

# Check if curl is installed, if not, try to install it
if ! command -v curl &> /dev/null
then
    install_curl
fi

# Download and install Starship
echo "Downloading and installing Starship..."
curl -sS https://starship.rs/install.sh | sh

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "Starship has been successfully installed!"

    # Check if ~/.bashrc exists
    if [ ! -f ~/.bashrc ]; then
        echo "~/.bashrc does not exist. Creating it..."
        touch ~/.bashrc
    fi

    # Check if Starship init is already in ~/.bashrc
    if ! grep -q "starship init bash" ~/.bashrc; then
        echo "Adding Starship init to ~/.bashrc..."
        echo 'eval "$(starship init bash)"' >> ~/.bashrc
        echo "Starship init added to ~/.bashrc"
        
        # Source ~/.bashrc
        echo "Applying changes to current session..."
        source ~/.bashrc
        echo "Changes applied. Starship is now active in your current session."
    else
        echo "Starship init is already in ~/.bashrc"
    fi

else
    echo "There was an error installing Starship. Please check your internet connection and try again."
    exit 1
fi

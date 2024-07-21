#!/bin/bash 
 


echo "What's the package to check?"

read package

if rpm -qa | grep -q "$package"; then
    echo "Package '$package' is already installed."
else
    echo "Installing the package '$package', please wait..."
    sleep 2

    if command -v yum &>/dev/null; then
        sudo yum install -y "$package"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$package"
    else
        echo "Error: Neither 'yum' nor 'dnf' package managers are available on this system."
        exit 1
    fi

    if [ $? -eq 0 ]; then
        echo "Package '$package' installed successfully!"
    else
        echo "Failed to install package '$package'. It may not exist in the repositories."
        exit 1
    fi
fi


#!/bin/bash

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${YELLOW}[*] Updating & Upgrading packages...${RESET}"
pkg update -y && pkg upgrade -y

# Termux packages list
termux_packages=(
    figlet
    toilet
    ruby
    ncurses-utils
    zip unzip
    coreutils
)

# Python packages list (pip)
python_packages=(
    zstandard==0.15.2
    rich
    requests
    tqdm
    figlet
    pyfiglet
    zstd
    colorama
)

# Install Termux packages
for pkg in "${termux_packages[@]}"; do
    if command -v "$pkg" &> /dev/null; then
        echo -e "${GREEN}[INSTALLED]${RESET} $pkg"
    else
        echo -e "${YELLOW}[INSTALLING]${RESET} $pkg..."
        pkg install -y "$pkg" && echo -e "${GREEN}[INSTALLED]${RESET} $pkg" || echo -e "${RED}[FAILED]${RESET} $pkg"
    fi
done

# Install Python packages
for pypkg in "${python_packages[@]}"; do
    pkg_name=$(echo "$pypkg" | cut -d'=' -f1) # sirf name nikalo
    if python -c "import $pkg_name" &> /dev/null; then
        echo -e "${GREEN}[INSTALLED]${RESET} $pypkg"
    else
        echo -e "${YELLOW}[INSTALLING]${RESET} $pypkg..."
        pip install "$pypkg" && echo -e "${GREEN}[INSTALLED]${RESET} $pypkg" || echo -e "${RED}[FAILED]${RESET} $pypkg"
    fi
done

# Install lolcat gem
if gem list -i lolcat &> /dev/null; then
    echo -e "${GREEN}[INSTALLED]${RESET} lolcat"
else
    echo -e "${YELLOW}[INSTALLING]${RESET} lolcat..."
    gem install lolcat && echo -e "${GREEN}[INSTALLED]${RESET} lolcat" || echo -e "${RED}[FAILED]${RESET} lolcat"
fi

echo -e "${GREEN}✔ All Done!${RESET}"
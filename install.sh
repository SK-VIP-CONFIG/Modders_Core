#!/bin/bash

clear

# ===============================
# MODDERS CORE INSTALLER
# ===============================

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Banner
echo -e "${CYAN}"
echo "╔══════════════════════════════════╗"
echo "║        MODDERS CORE INSTALLER     ║"
echo "║      PUBG / BGMI TOOL SETUP       ║"
echo "╚══════════════════════════════════╝"
echo -e "${NC}"

sleep 1

# Python check
echo -e "${YELLOW}[+] Checking Python...${NC}"
if ! command -v python &>/dev/null; then
    echo -e "${RED}[-] Python not found! Install Python first.${NC}"
    exit 1
fi
echo -e "${GREEN}[✓] Python found${NC}"

# Pip check
echo -e "${YELLOW}[+] Checking pip...${NC}"
if ! command -v pip &>/dev/null; then
    echo -e "${CYAN}[+] Installing pip...${NC}"
    python -m ensurepip --upgrade
fi
echo -e "${GREEN}[✓] pip ready${NC}"

# Git check
echo -e "${YELLOW}[+] Checking git...${NC}"
if ! command -v git &>/dev/null; then
    echo -e "${CYAN}[+] Installing git...${NC}"
    pkg install git -y 2>/dev/null || apt install git -y
fi
echo -e "${GREEN}[✓] git ready${NC}"

sleep 1

# Upgrade pip
echo -e "${CYAN}[+] Upgrading pip...${NC}"
pip install --upgrade pip

# Required modules from 2.py
echo -e "${YELLOW}[+] Installing required Python modules...${NC}"

pip install \
requests \
rich \
colorama \
pyfiglet \
pycryptodome \
zstandard \
gmalg || {
    echo -e "${RED}[-] Module installation failed!${NC}"
    exit 1
}

echo -e "${GREEN}[✓] All Python modules installed${NC}"

sleep 1

# Clone Modders_Core
echo -e "${CYAN}[+] Downloading Modders_Core...${NC}"

if [ -d "Modders_Core" ]; then
    echo -e "${YELLOW}[!] Modders_Core already exists, skipping clone${NC}"
else
    git clone https://github.com/SK-VIP-CONFIG/Modders_Core.git || {
        echo -e "${RED}[-] Git clone failed!${NC}"
        exit 1
    }
fi

sleep 1

# Setup permissions
echo -e "${CYAN}[+] Setting permissions...${NC}"
cd Modders_Core || exit
chmod +x *

echo -e "${GREEN}[✓] Permissions applied${NC}"

sleep 1

# Run tool
echo -e "${GREEN}[+] Launching Modders_Core...${NC}"
./Modders_Core
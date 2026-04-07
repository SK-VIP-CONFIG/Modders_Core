#!/bin/bash
clear

# ===============================
# MODDERS CORE INSTALLER (SAFE)
# ===============================

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Banner
echo -e "${CYAN}"
echo "╔══════════════════════════════════════╗"
echo "║        MODDERS CORE INSTALLER         ║"
echo "║        PUBG / BGMI TOOL SETUP         ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

sleep 1

# -------- Python --------
echo -e "${YELLOW}[+] Checking Python...${NC}"
if ! command -v python &>/dev/null; then
    echo -e "${RED}[-] Python not found. Install Python first.${NC}"
    exit 1
fi
echo -e "${GREEN}[✓] Python found${NC}"

# -------- pip --------
echo -e "${YELLOW}[+] Checking pip...${NC}"
if ! command -v pip &>/dev/null; then
    echo -e "${CYAN}[+] Installing pip...${NC}"
    python -m ensurepip --upgrade || {
        echo -e "${RED}[-] pip installation failed${NC}"
        exit 1
    }
fi
echo -e "${GREEN}[✓] pip ready${NC}"

# -------- git --------
echo -e "${YELLOW}[+] Checking git...${NC}"
if ! command -v git &>/dev/null; then
    echo -e "${CYAN}[+] Installing git...${NC}"
    pkg install git -y 2>/dev/null || apt install git -y
fi
echo -e "${GREEN}[✓] git ready${NC}"

# -------- pip upgrade --------
echo -e "${CYAN}[+] Upgrading pip...${NC}"
pip install --upgrade pip >/dev/null 2>&1

# -------- Python modules --------
echo -e "${YELLOW}[+] Installing required Python modules...${NC}"

pip install \
requests \
rich \
zstd \
colorama \
pyfiglet \
pycryptodome \
zstandard \
gmalg || {
    echo -e "${RED}[-] Python module installation failed${NC}"
    exit 1
}

echo -e "${GREEN}[✓] All Python modules installed${NC}"

# -------- Clone repo --------
echo -e "${CYAN}[+] Downloading Modders_Core...${NC}"

if [ -d "$HOME/Modders_Core" ]; then
    echo -e "${YELLOW}[!] Modders_Core already exists — skipping clone${NC}"
else
    git clone https://github.com/SK-VIP-CONFIG/Modders_Core.git "$HOME/Modders_Core" || {
        echo -e "${RED}[-] Git clone failed${NC}"
        exit 1
    }
fi

# -------- Permissions --------
echo -e "${CYAN}[+] Setting executable permissions...${NC}"
cd "$HOME/Modders_Core" || exit 1
chmod +x *

echo -e "${GREEN}[✓] Permissions set${NC}"

# -------- Create Global Command --------
echo -e "${CYAN}[+] Creating global command...${NC}"

CMD_PATH="$PREFIX/bin/Modders_Core"

cat > $CMD_PATH << 'EOF'
#!/bin/bash
cd $HOME/Modders_Core && ./Modders_Core
EOF

chmod +x $CMD_PATH

echo -e "${GREEN}[✓] Command created: Modders_Core${NC}"

# -------- Finish --------
echo
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}✔ MODDERS CORE INSTALLED SUCCESSFULLY${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo
echo -e "${CYAN}Now you can run from anywhere:${NC}"
echo -e "${YELLOW}Modders_Core${NC}"
echo
echo -e "${RED}⚠ Do NOT run via curl | bash (interactive login required)${NC}"
echo -e "${GREEN}Enjoy 🔥${NC}"
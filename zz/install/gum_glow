#!/bin/bash
## gum installer
printf %b "\n\n\n\n\e[4A\n -- installing gum and glow --\n\n]"; 
sudo mkdir -p /etc/apt/keyrings; 
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg; 
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list; 
sudo apt update && sudo apt install -y gum glow; 

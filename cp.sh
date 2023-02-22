curl -sS https://installer.cloudpanel.io/ce/v2/install.sh -o install.sh; \
echo "eddff7944a111a0d68eab513a58ffeb2ade63a85b448c36c32ad581c647c7a6f install.sh" | \
sha256sum -c && sudo bash install.sh

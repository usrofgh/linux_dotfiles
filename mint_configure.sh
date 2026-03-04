export DEBIAN_FRONTEND=noninteractive
sudo sed -i '/cdrom:/s/^/#/' /etc/apt/sources.list


rm -rf ~/Templates ~/Music ~/Pictures ~/Videos ~/Public

sudo apt update -y
sudo apt upgrade -y
sudo apt install dconf-editor -y
sudo apt install xclip -y
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo apt install wireshark -y
###############  AWS       #####################
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip


##############   NVIM ##########################
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
sudo wget https://archive.kali.org/archive-keyring.gpg -O /usr/share/keyrings/kali-archive-keyring.gpg

###############  KEEPASSXC #####################
sudo add-apt-repository -y ppa:phoerious/keepassxc && sudo apt update && sudo apt install -y keepassxc
###############  UV #####################
curl -LsSf https://astral.sh/uv/install.sh | sh
############## POETRY ###################
curl -sSL https://install.python-poetry.org | python3 -
poetry config virtualenvs.in-project true
########################    GOOGLE CHROME ####################################
curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb && rm -f goo*.deb

########################    OBSIDIAN    #####################################
wget $(wget -qO- https://obsidian.md/download | grep -oP 'https://github.com/obsidianmd/obsidian-releases/releases/download/v[\d.]+/obsidian_[\d.]+_amd64.deb' | head -n 1) && sudo dpkg -i obs*.deb && rm -f obs*.deb

######################      POSTMAN     #####################################
curl -L "https://dl.pstmn.io/download/latest/linux_64" -o postman.tar.gz && sudo tar -xzf postman.tar.gz -C /opt  && rm postman.tar.gz
echo '[Desktop Entry]
Version=1.0
Type=Application
Name=Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Exec=/opt/Postman/Postman
Comment=API platform for building and using APIs
Categories=Development;Network;
Terminal=false' > ~/.local/share/applications/postman.desktop

########################    PYCHARM    #####################################
wget https://download.jetbrains.com/python/pycharm-2025.3.1.1.tar.gz
sudo tar -xzf pycharm-2025.3.1.1.tar.gz -C  /opt
rm pycharm-2025.3.1.1.tar.gz
unzip jetbra.zip
bash jetbra/scripts/install.sh

echo '[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm
Icon=/opt/pycharm-2025.3.1.1/bin/pycharm.png
Exec=/opt/pycharm-2025.3.1.1/bin/pycharm
Comment=The Python IDE
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm' > ~/.local/share/applications/pycharm.desktop

#######################     TELEGRTAM  ######################################
curl -L "https://telegram.org/dl/desktop/linux" | sudo tar -xJf - -C /opt

######################      DOCKER    #######################################
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 3. Add the repository using 'noble' instead of 'zena'
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  noble stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 5. Post-installation (Enable running without sudo)
sudo groupadd docker || true
sudo usermod -aG docker $USER


###################       CLOUDFLARE WARP ##########################################
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com noble main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt update && sudo apt install cloudflare-warp -y
warp-cli --accept-tos registration new
warp-cli --accept-tos connect
curl https://www.cloudflare.com/cdn-cgi/trace/
warp-cli --accept-tos disconnect
#############################################################################
dconf load / < configuration
echo "DONE"

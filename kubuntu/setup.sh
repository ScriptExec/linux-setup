# Setup zsh
sudo apt install zsh zsh-syntax-highlighting zsh-autosuggestions
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
cp ../common/.zshrc ~/.zshrc

sudo apt install -y build-essential git

# Set default shell to zsh
chsh -s $(which zsh)

# Enable dark mode for KDE Plasma
lookandfeeltool -a org.kde.breezedark.desktop

# Enable background blur in Konsole
konsole_profile=$(grep -l "KonsoleProfile" ~/.local/share/konsole/*.profile | head -n 1)
if [ -n "$konsole_profile" ]; then
	kwriteconfig5 --file "$konsole_profile" --group "General" --key "Blur" "true"
fi

# Enable blur in KDE Plasma (for panels and menus)
kwriteconfig5 --file kwinrc --group Compositing --key Enabled true
kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled true
qdbus org.kde.KWin /KWin reconfigure

# Install Microsoft VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code

# Install Chromium Browser
sudo apt install chromium-browser
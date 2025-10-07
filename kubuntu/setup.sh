sudo apt install -y build-essential git

# Setup zsh
sudo apt  -y install zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp ../common/.zshrc ~/.zshrc

# Set default shell to zsh
chsh -s $(which zsh)

# Enable dark mode for KDE Plasma
lookandfeeltool -a org.kde.breezedark.desktop

# Enable background blur in Konsole
konsole_profile_dir="$HOME/.local/share/konsole"
profile_name="Main.profile"
profile_path="$konsole_profile_dir/$profile_name"

mkdir -p "$konsole_profile_dir"

cat > "$profile_path" <<EOF
[General]
Name=Main
Icon=utilities-terminal
ColorScheme=Breeze
Transparency=0.75
Blur=true
EOF

kwriteconfig5 --file "$konsole_profile_dir/Shell.profile" --group General --key Transparency 0.75
kwriteconfig5 --file "$konsole_profile_dir/Shell.profile" --group General --key Blur true

kwriteconfig5 --file "$konsole_profile_dir/konsole.conf" --group "Desktop Entry" --key DefaultProfile "$profile_name"

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
xdg-settings set default-web-browser chromium-browser.desktop

# Setup mouse cursor
git clone https://github.com/yeyushengfan258/Win10OS-cursors
cd ./Win10OS-cursors
chmod +x ./install.sh && sudo ./install.sh
cd ../
kwriteconfig5 --file ~/.config/kcminputrc --group Mouse --key cursorTheme Win10OS Cursors

# Clean up
rm -rf Win10OS-cursors
rm packages.microsoft.gpg
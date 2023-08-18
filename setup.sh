sudo apt update

#install google chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

#install brave
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

#install screen saver
sudo apt -y install kali-screensaver
sudo apt -y install hollywood-activate

#install aws cli
cd ~
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip


#setup git
git config --global user.name "ved"
git config --global user.email "vedbansal31@gmail.com"

#youtube api
cd ~
git clone https://github.com/vedantbansal/youtube_api.git
pip install google-api-python-client
echo "alias yt='python3 ~/youtube_api/playlist_duration.py'" >> .zshrc
source ./.zshrc



sudo apt upgrade -y

# Install git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update -y
sudo apt-get install git -y

# SSH keys
[ ! -f ~/.ssh/id_rsa ] && ssh-keygen

# git config
read -p "Enter git email: " git_email
git config --global user.email $git_email
read -p "Enter git name: " git_name
git config --global user.name $git_name
# git will push current branch without asking
git config --global push.default current
# git will cache credentials
git config --global credential.helper store

# curl and ctags
sudo apt-get install -y curl
sudo apt-get install -y ctags

# Makes and installs 2GB swapfile
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sysctl vm.swappiness=10
sudo sysctl vm.vfs_cache_pressure=50
sudo sh <<SCRIPT
sudo echo -e '\n/swapfile   none    swap    sw    0   0\n' >> /etc/fstab
sudo echo -e 'vm.swappiness=10' >> /etc/sysctl.conf
sudo echo -e 'vm.vfs_cache_pressure = 50' >> /etc/sysctl.conf
SCRIPT

# Sets up firewall
sudo apt-get install ufw -y
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing
# Firewall rules
sudo ufw allow ssh
sudo ufw allow ftp
sudo ufw allow www
sudo ufw allow 3000/tcp
sudo ufw allow 25000/tcp
sudo ufw enable

# Install nvm with latest node
export NVM_DIR=$HOME/.nvm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh
source $HOME/.nvm/nvm.sh
nvm install stable
nvm use stable
echo -e '\nsource ~/.nvm/nvm.sh\n' >> ~/.bashrc
echo -e 'nvm use stable\n' >> ~/.bashrc

# Install trash CLI
sudo npm install -g trash

# heroku toolbelt
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku login
heroku keys:add

# Installs rvm, latest ruby, and tmuxinator + pry gems
cd $HOME
sudo apt-get update
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source $HOME/.rvm/scripts/rvm
rvm gemset use global
gem install tmuxinator
gem install pry
gem install awesome_print
gem install md2man
rvm gemset use default

# Installs phantomjs v1.9.8
read -r -p "Install phantomjs? [y/N] " response
response=${response,,}    # tolower
if [[ $response =~ ^(yes|y)$ ]]
    sudo apt-get install build-essential chrpath libssl-dev libxft-dev -y
    sudo apt-get install libfreetype6 libfreetype6-dev -y
    sudo apt-get install libfontconfig1 libfontconfig1-dev -y
    cd $HOME
    export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
    wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
    sudo mv $PHANTOM_JS.tar.bz2 /usr/local/share/
    cd /usr/local/share/
    sudo tar xvjf $PHANTOM_JS.tar.bz2
    sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/share/phantomjs
    sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin/phantomjs
    sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/bin/phantomjs
    cd $HOME
fi

# Installs and sets up postgres
read -r -p "Install phantomjs? [y/N] " response
response=${response,,}    # tolower
if [[ $response =~ ^(yes|y)$ ]]
    sudo apt-get install postgresql postgresql-contrib libpq-dev -y
    sudo -u postgres createuser --superuser root
    sudo -u postgres psql -U postgres -d postgres -c "alter user root with password '';"
fi

# Installs direnv
cd $HOME
sudo apt-get install golang -y
git clone http://github.com/zimbatm/direnv
cd direnv
sudo make install
echo -e '\neval "$(direnv hook bash)"\n' >> ~/.bashrc

# Installs dotfiles
cd $HOME
pip install mackup

ZIP_LINK=https://www.dropbox.com/sh/o2jxysfs3rrtslq/AABodkj1wWjgUpmXF8vlBxn_a?dl=1
wget -O mackup.zip $ZIP_LINK
mkdir ~/mackup/Mackup
unzip mackup.zip -d ~/mackup/Mackup
cat > ~/.mackup.cfg <<EOF
[storage]
engine = file_system
path = mackup
directory = Mackup
EOF

mackup restore

# Install zsh
sudo apt-get install -y zsh
echo -e '\nhash zsh 2>/dev/null && exec zsh -l \n' >> ~/.profile

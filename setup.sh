# Install git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update -y
sudo apt-get install git -y

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
sudo echo -e '\n/swapfile   none    swap    sw    0   0' >> /etc/fstab
sudo echo -e '\nvm.swappiness=10' >> /etc/sysctl.conf
sudo echo -e '\nvm.vfs_cache_pressure = 50' >> /etc/sysctl.conf
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
export default_nvm_version=5.0
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh
source $HOME/.nvm/nvm.sh
nvm install $default_nvm_version
nvm use $default_nvm_version
echo -e '\nsource ~/.nvm/nvm.sh' >> ~/.bashrc
echo -e "nvm use $default_nvm_version &> /dev/null" >> ~/.bashrc

# Install trash CLI and replace rm
sudo npm install -g trash
alias rm=trash

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

# Installs phantonjs v1.9.8
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

# Installs and sets up postgres
cd $HOME
sudo apt-get install postgresql postgresql-contrib libpq-dev -y
sudo -u postgres createuser --superuser root
sudo -u postgres psql -U postgres -d postgres -c "alter user root with password '';"

# Installs direnv
cd $HOME
sudo apt-get install golang -y
git clone http://github.com/zimbatm/direnv
cd direnv
sudo make install
echo -e '\neval "$(direnv hook bash)"' >> ~/.bashrc

# Installs dotfiles
read -p "Do you want to install Sam's dotfiles? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd $HOME
    git clone https://github.com/SamLau95/vm-dotfiles.git
    ln -sb vm-dotfiles/.profile .
    ln -sb vm-dotfiles/.bashrc .
    ln -sb vm-dotfiles/.bash_aliases .
    ln -sb vm-dotfiles/.pryrc .
    ln -sb vm-dotfiles/.tmux.conf .
    ln -sb vm-dotfiles/.inputrc .
    source ~/.profile
    source ~/.bashrc
fi

# Installs vim config
read -p "Do you want to install spf13's vim config? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    curl http://j.mp/spf13-vim3 -L -o - | sh
fi

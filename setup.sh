git config --global push.default current

sudo apt-get install -y curl

sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo -e '\n/swapfile   none    swap    sw    0   0' >> /etc/fstab
sudo sysctl vm.swappiness=10
sudo echo -e '\nvm.swappiness=10' >> /etc/sysctl.conf
sudo sysctl vm.vfs_cache_pressure=50
sudo echo -e '\nvm.vfs_cache_pressure = 50' >> /etc/sysctl.conf

sudo apt-get install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow ftp
sudo ufw allow www
sudo ufw allow 3000/tcp
sudo ufw enable

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12
echo -e '\nsource ~/.nvm/nvm.sh' >> ~/.bashrc

git config --global credential.helper store

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

sudo apt-get install -y ctags

cd $HOME

sudo apt-get update
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
rvm gemset use global
gem install tmuxinator
gem install pry
rvm gemset use default

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
sudo apt-get install postgresql postgresql-contrib libpq-div
sudo -u postgres createuser --superuser root
sudo -u postgres psql -U postgres -d postgres -c "alter user root with password '';"

cd $HOME
sudo apt-get install golang -y
git clone http://github.com/zimbatm/direnv
cd direnv
make install
echo -e '\neval "$(direnv hook bash)"' >> ~/.bashrc

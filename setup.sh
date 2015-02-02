sudo apt-get install -y curl
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh

source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

git config --global credential.helper store

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

cd $HOME

gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby

sudo apt-get update
sudo apt-get install build-essential chrpath libssl-dev libxft-dev -y

sudo apt-get install libfreetype6 libfreetype6-dev -y
sudo apt-get install libfontconfig1 libfontconfig1-dev -y

export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2

sudo mv $PHANTOM_JS.tar.bz2 /usr/local/share/
cd /usr/local/share/
sudo tar xvjf $PHANTOM_JS.tar.bz2
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/share/phantomjs
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin/phantomjs
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/bin/phantomjs




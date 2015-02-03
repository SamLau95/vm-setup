Ubuntu Setup
=====

Sets up a fresh Ubuntu machine with config that I like.
Install ```git``` first:

    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt-get update
    sudo apt-get install git -y

Then clone the repo and run the script

    git clone https://github.com/SamLau95/ubuntu-setup/
    cd ubuntu-setup
    ./setup.sh

Features
====

- ```curl```
- ```nvm``` with ```nodejs``` v0.10.12
- Caches ```git``` credentials
- ```heroku``` toolbelt
- ```ctags```
- ```rvm``` with latest ```ruby```
- ```tmuxinator``` and ```pry```
- ```phantomjs``` v1.9.8
- ```postgresql``` with user ```root``` and blank password
- ```direnv```

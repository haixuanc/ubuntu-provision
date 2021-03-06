# -----------------------------------------------------------------------------
# Install System Dev Tools 
# -----------------------------------------------------------------------------
sudo sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
sudo apt-get update && \
sudo apt-get -y upgrade && \
sudo apt-get install -y build-essential && \
sudo apt-get install -y software-properties-common && \
sudo apt-get install -y byobu curl git htop man unzip vim wget ack-grep && \
sudo rm -rf /var/lib/apt/lists/*

# Rename `ack-grep` to `ack`
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# -----------------------------------------------------------------------------
# Install oh-my-zsh
# -----------------------------------------------------------------------------
sudo apt-get update && \
sudo apt-get install zsh && \
sudo chsh -s /bin/zsh && \
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# -----------------------------------------------------------------------------
# Install Docker
# -----------------------------------------------------------------------------
which wget
if [ $? -eq 1 ]; then
	sudo apt-get update && sudo apt-get install wget
fi
wget -qO- https://get.docker.com | sh

# Add user `hchen` to `docker` user group, so you don't need to sudo docker
# commands
sudo usermod -aG docker hchen

sudo -u hchen docker run hello-world && STATUS=$?
echo "------------------------------------------------------------------------"
if [ $STATUS -eq 0 ]; then 
	echo -e "Docker installed successfully"
else
	echo -e "Failed to install Docker"
fi
echo "------------------------------------------------------------------------"

# -----------------------------------------------------------------------------
# Install Docker-compose
# -----------------------------------------------------------------------------

which curl
if [ $? -eq 1 ];then
	sudo apt-get update && sudo apt-get install curl
fi

curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# [OPTIONAL] Install `docker-compose` command completion
curl -L https://raw.githubusercontent.com/docker/compose/1.10/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

docker-compose --version && STATUS=$?
echo "------------------------------------------------------------------------"
if [ $STATUS -eq 0 ]; then
	echo -e "Docker-compose installed successfully"
else
	echo -e "Failed to install Docker-compose"
fi
echo "------------------------------------------------------------------------"

# -----------------------------------------------------------------------------
# Install NodeJS
# -----------------------------------------------------------------------------
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs

# [OPTIONAL] Install build tools to compile and install addons from npm
sudo apt-get install -y build-essential

npm --version && STATUS=$?
echo "------------------------------------------------------------------------"
if [ $STATUS -eq 0 ]; then
	echo -e "NodeJS installed successfully"
else
	echo -e "Failed to install NodeJS"
fi
echo "------------------------------------------------------------------------"

# Install nodemon
sudo npm install -g nodemon

# -----------------------------------------------------------------------------
# Install Java8
# -----------------------------------------------------------------------------
JAVA_VERSION=8
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true \
	| /usr/bin/debconf-set-selections
apt-get -y install oracle-java${JAVA_VERSION}-installer
rm -rf /var/lib/apt/lists/*

java -version && STATUS=$?
echo "------------------------------------------------------------------------"
if [ $STATUS -eq 0 ]; then
	echo -e "Java installed successfully"
else
	echo -e "Failed to install Java"
fi
echo "------------------------------------------------------------------------"

# Set JAVA_HOME
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bash_profile 
sudo source ~/.bash_profile

# -----------------------------------------------------------------------------
# install maven
# -----------------------------------------------------------------------------
sudo apt-get update
sudo apt-get install -y maven

mvn -version && status=$?
echo "------------------------------------------------------------------------"
if [ $status -eq 0 ]; then
	echo -e "maven installed successfully"
else
	echo -e "failed to install maven"
fi
echo "------------------------------------------------------------------------"

# -----------------------------------------------------------------------------
# Install Git
# -----------------------------------------------------------------------------
sudo apt-get update
sudo apt-get install git

git --version && STATUS=$?
echo "------------------------------------------------------------------------"
if [ $STATUS -eq 0 ]; then
	echo -e "Git installed successfully"
else
	echo -e "Failed to install Git"
fi
echo "------------------------------------------------------------------------"

# Add global gitignore
cp configs/.gitignore_global ~
git config --global core.excludesfile ~/.gitignore_global

# -----------------------------------------------------------------------------
# Install Vim plugins (need to use Git)
# -----------------------------------------------------------------------------
# Install pathogen (a vim plugin manager)
sudo mkdir -p ~/.vim/autoload ~/.vim/bundle && \
sudo curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install plugins with pathogen
cd ~/.vim/bundle
# Install solarized theme
git clone https://github.com/altercation/vim-colors-solarized.git && \
# Install NERDTree
# After installation, open vim and run commands: `:Helptags`, `help NERD_tree.txt`
git clone https://github.com/scrooloose/nerdtree.git

# -----------------------------------------------------------------------------
# Add Essential Configurations
# -----------------------------------------------------------------------------
# After add, open vim and run command `:source ~/.vimrc`
cp configs/.vimrc ~/.vimrc

# -----------------------------------------------------------------------------
# Install ruby via rvm
# -----------------------------------------------------------------------------
sudo apt-get install curl && \
\curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles && \
source ~/.rvm/scripts/rvm && \
rvm requirements && \
rvm install ruby && \
rvm use ruby default && \
rvm rubygems current && \
gem install rails

# macos
Scripts to setup macos machine

#Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

##Note:
Installing brew will make sure that Command Line Tools for Xcode is installed.  If it can't find it. It will install it for you silently.!!! YAY

#Check status of brew
brew doctor
cd ~/projects
mkdir projects
cd projects

##Clone my github repo for macos installation
git clone https://github.com/azimmerman0125/macos.git


cd macos/scripts

#run base script
./setup.sh

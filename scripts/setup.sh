#!/bin/bash


cmds=("brew" "ls")
brewCaskPkgs=(
              'iterm2' 
              'visual-studio-code'
              'tiles'
              'clipy'
              'google-chrome'
              'microsoft-office'
         )
brewPkgs=(
              'python3'
	      'mas'
              'gh'
	)

masPkgs=(
               'greenshot:1103915944'
        )

installBrew () {
  /bin/bash -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

}


installBrewCaskPackages () {

  for pkg in ${brewCaskPkgs[@]}; do
    echo "Install Cask Pkg: $pkg"
    brew install --cask $pkg
  done

}

installBrewPackages () {

  for pkg in ${brewPkgs[@]}; do
    echo "Install Pkg: $pkg"
    brew install $pkg
  done

}

linkPython () {
  ls /usr/local/bin/python 1>&2 2>/dev/null
  if [ $rc ]; then
     ln -s /usr/local/bin/python3 /usr/local/bin/python
  else
    echo "Python link already exists"
  fi
  
}

installAppStoreApps () {
  for pkg in ${masPkgs[@]}; do
    appName=$(echo $pkg | awk -F: '{print $1}')
    appId=$(echo $pkg | awk -F: '{print $2}')
    echo "Install App Store App : $appName"
    mas install $appId
  done

}

for cmd in ${cmds[@]}; do
  #cmd=${cmds[$i]}
  echo $cmd
  chk=$(which "$cmd")
  rc=$? 

  if [ "$rc" = "0" ]; then
    echo "  Already installed: $cmd"
    continue
  fi

case $cmd in

    brew)
     installBrew

    ;;

    *)
      echo "unknown"
    ;;
  esac
done



installBrewCaskPackages
installBrewPackages

linkPython

installAppStoreApps



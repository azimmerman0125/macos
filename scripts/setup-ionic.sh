#!/bin/bash


cmds=("brew" "ls")
brewCaskPkgs=(
         )
brewPkgs=(
              'node'
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

npm install -g @ionic/cli

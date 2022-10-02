#!/bin/bash

#working dir
if [[ "${0%/*}" != "$0" ]];then
  working_dir="${0%/*}"
else
  working_dir="."
fi

##MUST manually download Xcode before running this script
REMOVEXCODEXIP=false

Usage () {
  echo "Usage: $0 -f </path/to/Xcode.zip file>"
  echo "          -x <version of xcode>"
  echo "          -r       Remove xcode.xip file"
}

if (( $# < 2 )); then
  Usage
  exit 1
fi

if [[ -d /Applications/Xcode.app ]]; then
  echo "/Applications/Xcodee.app already exists.  Please resolve conflict before proceeding"
  exit 1
fi

XIP=$(which xip 2>/dev/null)

if [[ ${XIP} == "" ]];then
    echo "xip command not found."
    echo "Install xip cli tool. Exiting!!!"
    exit 1
fi


##Process Arguments
set -- `getopt f:x:r "$@"`
[ $# -lt 1 ] && exit 1  # getopt failed
while [[ $# -gt 0 ]]
 do
    case "$1" in
        -f)     XCODEXIP="$2"; shift;;
        -x)     XCODEVER="$2"; shift;;
        -r)     REMOVEXCODEXIP=true; shift;;
        --)     shift; break;;
        -*)     Usage; exit 1; break ;;
        *)      break;;         # terminate while loop
    esac
    shift
done

XCODEDIR="Xcode.${XCODEVER}.app"

echo "Xcode File: ${XCODEXIP}"
echo "Xcode version: ${XCODEVER}"
echo "App Dir Name: ${XCODEDIR}"
if [[ $REMOVEXCODEXIP ]]; then
  echo "Remove Xcode.xip file ${REMOVEXCODEXIP}"
fi

echo ""
echo ""
read -n 1 -r -s -p $'Press enter to continue... or CTRL+C to exit\n'
echo ""

check=$(ls -d ${XCODEXIP} 2>/dev/null)
if [[ ${check} == "" ]]; then
  echo "Can't Find ${XCODEXIP}"
  echo "Exiting...."
  exit 1
fi


cd /Applications
echo "Extracting ${XCODEXIP} to /Applications"
${XIP} --expand ${XCODEXIP}


check=$(ls -d /Applications/Xcode.app 2>/dev/null)
if [[ ${check} == "" ]]; then
  echo "Something went wrong with Xcode Extract.."
  echo "Check for /Applications/Xcode.app"
  exit 1
fi

echo "Renaming Xcode.app to ${XCODEDIR}"
cd /Applications
mv Xcode.app $XCODEDIR

check=$(ls -d /Applications/${XCODEDIR} 2>/dev/null)
if [[ ${check} == "" ]]; then
  echo "Something went wrong with Xcode Dir Rename.."
  echo "Check for /Applications/${XCODEDIR}"
  exit 1
fi

echo "Switching xcode IDE"
sudo xcode-select --switch /Applications/${XCODEDIR}

echo "Installing xcode tools"
sudo xcode-select --install

if [[ "${REMOVEXCODEXIP}" == true ]]; then
  rm ${XCODEXIP}
fi

cd ${working_dir}
exit 0

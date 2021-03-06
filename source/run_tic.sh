#!/bin/bash

if uname | grep -iq darwin; then
  TIC_DIR="$HOME/Library/Application Support/com.nesbox.tic/TIC-80"
  CMD="open /Applications/tic.app"
else
  TIC_DIR="/c/Users/bruno/AppData/Roaming/com.nesbox.tic/TIC-80"
  CMD="../tic.exe"
fi

echo "TIC cartridge dir: $TIC_DIR"
echo "Copying panda.tic to $TIC_DIR/panda-dev.tic."

cp -vf panda.tic "$TIC_DIR/panda-dev.tic"

if ! [ -f "$TIC_DIR/panda-dev.tic" ]; then
  echo "*** Copy appears to have failed."
  exit 1
fi

echo "Starting TIC."
echo "Use 'load panda-dev' to load the cart."
$CMD

echo -n "Done editing cart? Copy it back to working dir? [Y/n] "
read ans
if [ "$ans" = "Y" -o "$ans" = "y" -o "$ans" = "" ]; then
  echo "Copying it back..."
  cp -vf "$TIC_DIR/panda-dev.tic" panda.tic
  mv "$TIC_DIR/panda-dev.tic" "$TIC_DIR/panda-dev.bak"
  echo "Done copying."
fi


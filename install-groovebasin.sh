#!/bin/bash

{
  sudo apt-get -y update
} &> /dev/null

echo "Installing nodejs v0.10.36....."
{
  # install nvm and node v0.10.36
  sudo apt-get -y remove --purge node nodejs
  sudo apt-get -y install build-essential checkinstall curl libssl-dev
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
  source ~/.profile
  nvm install v0.10.36
  nvm use v0.10.36
} &> /dev/null
echo "Installing some dependencies....."
{
  # install dependencies
  sudo apt-add-repository -y ppa:andrewrk/libgroove
  sudo add-apt-repository -y ppa:mc3man/trusty-media
  sudo apt-get -y update
  sudo apt-get -y install git cmake ffmpeg libebur128-dev libchromaprint-dev libsdl2-devlibavformat-dev libavcodec-dev libavfilter-dev libavutil-dev
  sudo apt-get -y install libgrooveplayer-dev libgrooveloudness-dev libgroovefingerprinter-dev libgroove-dev
} &> /dev/null
echo "Installing groovebasin....."
{
  # install groovebasin
  cd ~/
  git clone --branch 1.5.1 https://github.com/andrewrk/groovebasin.git
  cd groovebasin/
  npm run build
  npm start
} &> /dev/null
echo "Configuring groovebasin....."
{
  # configure
  chmod 666 config.json

  # make link to run with command groovebasin
  mv ~/groovebasin/ ~/.groovebasin
  touch ~/.groovebasin/run.sh
  sudo chmod 777 ~/.groovebasin/run.sh
  bash -c 'echo "#!/bin/bash" > ~/.groovebasin/run.sh'
  bash -c 'echo "cd ~/.groovebasin/" >> ~/.groovebasin/run.sh'
  bash -c 'echo "npm start" >> ~/.groovebasin/run.sh'
  ln -s ~/.groovebasin/run.sh /usr/bin/groovebasin
  sudo chmod 777 ~/.groovebasin/
} &> /dev/null

echo "The installation was successful. Configure file ~/.groovebasin/config.json and run with command groovebasin"

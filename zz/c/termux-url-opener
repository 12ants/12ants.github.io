#!/data/data/com.termux/files/usr/bin/bash
#
# This is a termux-url-opener script to do diffrent tasks on my Android phone 
#
#
#
# How to use this script
#############################
# 
# Install git
# ➜ ~ pkg install git
# 
# clone this script
# ➜ ~ git clone https://gist.github.com/dc35e8df3dc41d126683f18fe44ebe17.git $HOME/termux-url-opener
#
# Create the bin directory
# ➜ ~ mkdir bin
#
# Link the script
# ➜ ~ ln -s $HOME/termux-url-opener/termux-url-opener $HOME/bin/termux-url-opener
# ➜ ~ ln -s $HOME/termux-url-opener/termux-url-opener $HOME/bin/termux-file-editor
# 
# run the following command to enable the termux storage features
# ➜ termux-setup-storage
# 
# https://wiki.termux.com/wiki/Termux-setup-storage
#
# the script downloads the needed tools on first use.

for PACKAGE in wget ffmpeg python 
do
	which $PACKAGE > /dev/null
	if [ ! $? -eq 0 ]; then
		echo "Installing $PACKAGE"
		pkg install $PACKAGE
	fi
done

which transmission-daemon > /dev/null
if [ ! $? -eq 0 ]; then
	pkg install transmission
fi

for PYPI_PKG in yt-dlp scdl
do
	pip show $PYPI_PKG
	if [ ! $? -eq 0 ]; then
		pip install $PYPI_PKG
	fi
done

if [! -w $HOME/Downloads ]; then #create Downloads Link for transmission
	ln -s $HOME/storage/downloads $HOME/Downloads
fi

url=$1
echo "What should I do with $url ?"
echo "y) download youtube video to movies-folder"
echo "u) download youtube video and convert it to mp3 (music-folder)"
echo "s) download with scdl (soundcloud)"
echo "t) download torrent"
echo "w) wget file to download-folder" 
echo "x) nothing"

read CHOICE
case $CHOICE in
  y)
    yt-dlp -o "/storage/emulated/0/Movies/%(title)s.%(ext)s" $url
    ;;
    
  u)
    echo "Artist"
    read artist
    echo "Title"
    read title
    echo "Album"
    read album
    yt-dlp --extract-audio --audio-format mp3 --output "/storage/emulated/0/Music/$artist-$title.%(ext)s" $url
    mid3v2 -a $artist -t $title -A $album /storage/emulated/0/Music/$artist-$title.mp3
    ;;
  
  s)
    scdl -l $url --path /storage/emulated/0/Music
    echo "s need some work"
    ;;
  
  w)
    cd ~/storage/downloads
    wget $url
    ;;
  
  t)
    echo "running torrents"
    transmission-remote 127.0.0.1 -l
    if [ ! $? eq 0 ]; then # start daemon if necessary
      transmission-daemon
      sleep 3
    fi
    echo "use transmission-remote to manage your downloads (read the manpage)"
    transmission-remote 127.0.0.1 -a $(cat $url) 
    ;;
    
  x)
    echo "bye"
    ;; 
  esac

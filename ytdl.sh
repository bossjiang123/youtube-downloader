#!/bin/bash

# youtube-dl Video and Audio downloader script.
# Written by QuidsUp
# Edited by Christoph Korn
# Much much more edited by omerakgoz34 =)

# v1.1 - 8 May 2019

URL=$1
VAR=0

# Help message
if [ -z $URL ]; then
	echo
	echo "Usage: ytdl <URL>"
	echo
	echo "Dependencies: Python, youtube-dl, FFmpeg."
	echo
	exit
fi

DownType() {
    echo
    echo "1 = video"
    echo "2 = audio"
    echo "3 = video only"
    echo -n "Enter download type [1/2/3]: "
    read DownType
    echo
}

if [ $VAR = 0 ]; then
    VAR = 1
    DownType
fi

if [ $DownType = "1" ]; then
    # video
    
    youtube-dl -F $URL
    echo
    
    echo -n "Select quality for Video [default 136]: "
    read DownOptionV
    if [ -z $DownOptionV ]; then
        DownOptionV=136
    fi
    
    echo -n "Select quality for Audio [default 140]: "
    read DownOptionA
    if [ -z $DownOptionA ]; then
        DownOptionA=140
		  fi
		  echo
		  FileV=$(youtube-dl --get-filename -f $DownOptionV $URL)
		  FileA=$(youtube-dl --get-filename -f $DownOptionA $URL)
		  Out=${FileV:0:${#FileV}-16}
		  echo "File name: " $Out
		  
		  if [ $DownOptionV = "278" ]; then
		      echo done
		      exit
		  fi
else

if [ $DownType = "2" ]; then
    # audio
    
    echo akal
else

if [ $DownType = "3" ]; then
    # video only
    
    echo skak
else
    echo
    echo "* Wrong option!"
    echo
fi
fi
fi



# Finish
exit
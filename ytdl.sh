#!/bin/sh

# youtube-dl downloader script.
# Written by QuidsUp
# Edited by Christoph Korn
# Much much more edited by omerakgoz34 :)

# v1.1 - 8 May 2019

URL=$1

# Help message
if [ -z $URL ]; then
	echo ""
	echo "Usage: ./ytdl.sh <URL>"
	echo ""
	echo "Dependencies: Python, youtube-dl, FFmpeg."
	echo ""
	echo "This Script created by omerakgoz34"
	echo "Credits: omerakgoz34, Christoph Korn, QuidsUp"
	echo ""
	exit
fi

echo ""
echo "1 = video + audio"
echo "2 = video only"
echo "3 = audio"
echo -n "Enter download type [1/2/3]: "
read DownType
echo ""

if [ $DownType == "1" ]; then
    # video + audio

    youtube-dl -F $URL
    echo ""

    echo -n "Select quality for Video [default 136]: "
    read DownOptionV
    if [ -z $DownOptionV ]; then
        DownOptionV = 136
    fi

    echo -n "Select quality for Audio [default 140]: "
    read DownOptionA
    if [ -z $DownOptionA ]; then
        DownOptionA = 140
	fi
	echo ""
	FileV = $(youtube-dl --get-filename -f $DownOptionV $URL)
	FileA = $(youtube-dl --get-filename -f $DownOptionA $URL)
	Out = ${FileV:0:${#FileV}-16}

	youtube-dl -f $DownOptionV $URL
	if [ -f $FileV ]; then
		echo ""
        echo "* Video Download Failed."
		exit
	fi

	youtube-dl -f $DownOptionA $URL
	if [ -f $FileA ]; then
		echo ""
        echo "* Audio Download Failed."
		exit
	fi

	ffmpeg -i $FileV -i $FileA -threads 0 -c:v copy -c:a copy $Out
	if [ -f $Out ]; then
		echo ""
        echo "* Merging Failed."
		exit
	fi

	echo $Out "created."
	rm -f $FileV
	rm -f $FileA
else

if [ $DownType == "2" ]; then
    # video only
    echo "asd"
else

if [ $DownType == "3" ]; then
    # audio
    echo "asd"
else
    echo ""
    echo "* Wrong option!"
    echo ""
	exit
fi
fi
fi



# Done.
exit

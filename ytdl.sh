#!/bin/sh

# youtube-dl downloader script.
# Written by QuidsUp
# Edited by Christoph Korn
# Much much more edited by omerakgoz34 :)

# v2.1 - 24 Aug 2019

URL=$1
DownOptionA=140

# Help message
if [ -z $URL ]; then
	echo ""
	echo "Usage: ./ytdl.sh <URL>"
	echo ""
	echo "Dependencies: Python3, youtube-dl, FFmpeg."
	echo ""
	echo "This Script created by omerakgoz34"
	echo "Credits: omerakgoz34, Christoph Korn, QuidsUp"
	echo ""
	exit
fi

echo ""
echo "1 = MP4 + Audio"
echo "2 = MP4"
echo "3 = MP3"
echo ""
echo -n "Enter download type [1/2/3]: "
read DownType

if [ -z $DownType ]; then
	echo ""
	echo ">>> Wrong option!"
	echo ""
	exit
fi

if [ $DownType == 1 ]; then
    # MP4 + Audio

	echo ""
    youtube-dl -F $URL
    echo ""

    echo -n "Select quality for Video (mp4): "
    read DownOptionV
    if [ -z $DownOptionV ]; then
        DownOptionV=136
    fi

	echo ""
	FileV=$(youtube-dl --get-filename -f $DownOptionV $URL)
	FileA=$(youtube-dl --get-filename -f $DownOptionA $URL)
	Out="${FileV:0:${#FileV}-16}.mp4"

	youtube-dl -f $DownOptionV $URL -o "$FileV"
	if [ ! -f "$FileV" ]; then
		echo ""
        echo ">>> Video Download Failed."
		echo ""
		exit
	fi

	youtube-dl -f $DownOptionA $URL -o "$FileA"
	if [ ! -f "$FileA" ]; then
		echo ""
        echo ">>> Audio Download Failed."
		echo ""
		exit
	fi

	ffmpeg -i "$FileV" -i "$FileA" -threads 0 -c:v copy -c:a copy "$Out"
	if [ ! -f "$Out" ]; then
		echo ""
        echo ">>> Merging Failed."
		echo ""
		exit
	fi

	rm -f "$FileV"
	rm -f "$FileA"
	echo ""
	ehco ""
	ehco ""
	echo "* $Out created."
	echo ""
else

if [ $DownType == 2 ]; then
    # MP4

	echo ""
	youtube-dl -F $URL
    echo ""

    echo -n "Select quality for Video (mp4): "
    read DownOptionV
    if [ -z $DownOptionV ]; then
        DownOptionV=136
    fi

	echo ""
	FileV=$(youtube-dl --get-filename -f $DownOptionV $URL)
	Out="${FileV:0:${#FileV}-16}.mp4"

	youtube-dl -f $DownOptionV $URL -o "$Out"
	if [ ! -f "$Out" ]; then
		echo ""
        echo ">>> Video Download Failed."
		echo ""
		exit
	fi

	echo ""
	echo ""
	echo ""
	echo "* $Out created."
	echo ""
else

if [ $DownType == 3 ]; then
    # MP3

	echo ""
	FileA=$(youtube-dl --get-filename -f $DownOptionA $URL)
	Out="${FileA:0:${#FileA}-16}.mp3"

	youtube-dl -f $DownOptionA $URL -o "$FileA"
	if [ ! -f "$FileA" ]; then
		echo ""
        echo ">>> Audio Download Failed."
		echo ""
		exit
	fi

	ffmpeg -i "$FileA" -threads 0 -c:a libmp3lame -q:a 0 "$Out"
	if [ ! -f "$Out" ]; then
		echo ""
        echo ">>> Converting Failed."
		echo ""
		exit
	fi

	rm -f "$FileA"
	echo ""
	echo ""
	echo ""
	echo "* $Out created."
	echo ""
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

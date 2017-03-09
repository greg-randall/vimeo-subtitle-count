#!/bin/bash
echo "Enter the Vimeo Channel URL you want to test for subtitles then press ENTER:"

read channel 

echo "Processing Started! With this script most errors can be ignored. On a channel with many videos this script may take a few minutes to run."
echo ""

channelname=$( echo $channel | sed -E 's/.+\///g' )

youtube-dl --newline --list-subs --skip-download $channel > temp-subs.txt

echo $channel > $channelname-without-subs.txt
echo "Videos without subs:" >> $channelname-without-subs.txt 
grep 'no' temp-subs.txt | sed 's/[^0-9]*//g' | sed 's/^/https:\/\/vimeo.com\//' >> $channelname-without-subs.txt

echo $channel > $channelname-with-subs.txt
echo "Videos with subs:" >> $channelname-with-subs.txt
grep 'Available' temp-subs.txt | sed 's/[^0-9]*//g' | sed 's/^/https:\/\/vimeo.com\//' >> $channelname-with-subs.txt

rm temp-subs.txt

echo ""
echo "Done:"

nosubscount=$(wc -l < $channelname-without-subs.txt)
subscount=$(wc -l < $channelname-with-subs.txt)

let "nosubscount-=2"
let "subscount-=2"

echo "Videos without subs: $nosubscount"
echo "Videos with subs: $subscount"
echo ""

#!/bin/bash

##############################################################################
# Basic Config ###############################################################
video_dev="/dev/video0"
audio_dev="hw:0"
# Video Options ##############################################################
framerate="30"
video_size="640x480"
resolution="1280x720"
##############################################################################
# File Options ##############################################################
directory="/home/${USER}/Videos/"
video_ext=".mkv"
audio_ext=".mp3"
##############################################################################
# Colors #####################################################################
green='\e[32m'
blue='\e[34m'
clear='\e[0m'
red='\033[0;31m'
nc='\033[0m'
##############################################################################

function color_green() {
    echo -ne $green$1$clear
}

function color_blue() {
    echo -ne $blue$1$clear
}

function banner() {
    figlet -t -k Easy Record
}

function main_menu() {
    dependancies
    clear
    banner 

    echo -ne "
    Main Menu
    $(color_green '1)') Record with Webcam (with Audio)
    $(color_green '2)') Record with Webcam (no Audio)
    $(color_green '3)') Record Audio Only
    $(color_green '4)') Record Desktop (with Audio)
    $(color_green '5)') Record Desktop (no Audio)
    $(color_green '0)') Exit
    $(color_blue 'Choose an option:') "

    read A
            
        case $A in

        1) 
        clear ;
        banner ;

        echo -e "\n\e[4mEnter name of output file\e[0m " ;
        read -p "File: " file ;

        ffmpeg -f v4l2 -framerate $framerate -video_size $video_size -i $video_dev -f alsa -ac 2 -i $audio_dev ${directory}${file}${video_ext} ;
        ;;

        2) 
        clear ;
        banner ;

        echo -e "\n\e[4mEnter name of output file\e[0m " ;
        read -p "File: " file ;

        ffmpeg -f v4l2 -framerate $framerate -video_size $video_size -i $video_dev ${directory}${file}${video_ext} ;
        ;;

        3)
        clear ;
        banner ;

        echo -e "\n\e[4mEnter name of output file\e[0m " ;
        read -p "File: " file ;

        ffmpeg -f alsa -ac 2 -i $audio_dev ${directory}${file}${audio_ext} ;
        ;;

        4)
        clear ;
        banner ;

        echo -e "\n\e[4mEnter name of output file\e[0m " ;
        read -p "File: " file ;

        ffmpeg -f x11grab -framerate $framerate -s $resolution -i :0.0 -f alsa -ac 2 -i $audio_dev ${directory}${file}${video_ext} ;
        ;;

        5)
        clear ;
        banner ;

        echo -e "\n\e[4mEnter name of output file\e[0m " ;
        read -p "File: " file ;

        ffmpeg -f x11grab -framerate $framerate -s $resoltuion -i :0.0 ${directory}${file}${video_ext} ;
        ;;

        0) 
        exit 0 ;;
        
        *) 
        echo -e "${red}Wrong option${nc}" ;;
        esac
}

main_menu

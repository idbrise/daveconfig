#! /bin/bash

# Rebuild tags every minute

if [ $# -lt 1 ] ; then
    echo
    echo Error: You must provide the filetype
    echo Example: $0 java
    echo
    exit -1
fi
lang=$1
shift

# Set the title
#echo -ne "\033]0;tags -- ${USER::1}@${HOSTNAME::1}:${PWD/#$HOME/~}\007"
echo -ne "\033]0;continuous build: ${PWD/#$HOME/~}\007"

while true ; do
    echo building...
    case $lang in
        android)
            bash ~/.vim/scripts/build_android_tags.sh $*
            ;;
        *)
            bash ~/.vim/scripts/buildtags cscope $lang $*
            ;;
    esac
    echo done. sleeping.
    sleep 1m
done


#! /bin/bash

dconfig_path=~/data/settings/daveconfig

ln -s $dconfig_path/multi/vim ~/.vim
ln -s $dconfig_path/multi/vim/vimrc.vim ~/.vimrc
ln -s $dconfig_path/multi/vim/gvimrc.vim ~/.gvimrc

ln -s $dconfig_path/multi/git/.gitconfig ~/.
ln -s $dconfig_path/multi/git/.gitignore ~/.

config_dir=$dconfig_path/unix/terminal/
for a in `find $config_dir -maxdepth 1 -type f` ;do
    ln -s $a ~/.$(basename $a)
done

# Should these be in bin or PATH?
#ln -s --target-directory=$HOME/data/apps/bin/ $dconfig_path/multi/git/submanage/git-*
#ln -s --target-directory=$HOME/data/apps/bin/ $dconfig_path/multi/git/tool/*.git.sh

# bashrc is different on different platforms
function delete_if_symbolic {
    file=$1
    if [ -L $file ] ; then
        rm $file
    fi
}
if [ `uname` = 'Linux' ] ; then
    # linux uses bashrc, get rid of the profile or it will interfere
    delete_if_symbolic ~/.profile
else
    # mac uses profile, get rid of the bashrc
    delete_if_symbolic ~/.bashrc
fi

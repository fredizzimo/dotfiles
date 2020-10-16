# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -e /home/fredizzimo/.nix-profile/etc/profile.d/nix.sh ]; then . /home/fredizzimo/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:~/clang/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/
export PATH=$PATH:~/bin/pru-gcc/bin
export PATH=$PATH:/usr/local/go/bin

#export GDP_DPI_SCALE=1.75
#export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0 # in WSL 2
#export LIBGL_ALWAYS_INDIRECT=1

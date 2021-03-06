#!/bin/sh

export SCIM_BRIDGE_DEBUG_LEVEL="9"
export PATH=../agent/:${PATH}
export GTK_IM_MODULE_PATH=../client-gtk/.libs/
export GTK_IM_MODULE_FILE=../tests/gtk.immodules
export GTK_IM_MODULE=scim-bridge
export QT_IM_MODULE=scim-bridge

help_needed=0
if [ $# -eq 0 ]
then
    help_needed=1
elif [ $1 == "-h" -o $1 == "--help" ]
then
    help_needed=1
fi

if [ $help_needed -eq 1 ]
then
    echo "Usage: $0 [command] [command-arguments]"
    echo "Note that testing for the qt immodule is not well implemented"
fi

exec $@

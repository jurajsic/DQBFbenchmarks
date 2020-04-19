#!/bin/bash

# Removes DQDIMACS files which were solved by HQSpre
# Run as
#    ./removesolvedbyhqspre.sh DIR
# where DIR is the directory with the DQDIMACS files to clean.
# It is assumed they were copied from ../original/

if [[ $# -ne 1 ]]; then
    printf 'Wrong number of arguments, run "./removesolvedbyhqspre.sh --help" for help\n'
    exit 2
fi

if [[ $1 = '--help' || $1 = '-h' ]]; then
    printf 'Removes DQDIMACS files which were solved by HQSpre
Run as
   ./removesolvedbyhqspre.sh DIR
where DIR is the directory with the DQDIMACS files to clean.
It is assumed they were copied from ../original/
'
    exit 0
fi

comm -23 <(cd $1; ls) <(cd ../afterhqspre/$1; ls) > difference
cd $1
xargs rm < ../difference
cd ../
rm difference
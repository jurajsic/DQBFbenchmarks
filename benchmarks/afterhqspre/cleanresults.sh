#!/bin/bash

# Cleanser of the log files from benchexec run on HQSpre to make them normal DQDIMACS files
# Run as
#    ./cleanresults.sh DIR
# where DIR is the directory with the log files to clean.

if [[ $# -ne 1 ]]; then
    printf 'Wrong number of arguments, run "./cleanresults.sh --help" for help\n'
    exit 2
fi

if [[ $1 = '--help' || $1 = '-h' ]]; then
    printf 'Cleanser of the log files from benchexec run on HQSpre to make them normal DQDIMACS files
Run as
    ./cleanresults.sh DIR
where DIR is the directory with the log files to clean.
'
    exit 0
fi

# go to directory in which are the files to clean
cd $1

printf 'Removing ".log" from the end of filenames\n'
rename 's/.{4}$//' *
printf 'Removing "pipe." from the beginning of the filenames\n'
rename 's/^.{5}//' *
printf 'Deleting the first 6 lines in each file added by benchexec\n'
sed -i '1,6d' *
printf 'Deleting files for which HQSpre TIMEOUTed or was OUT OF MEMORY\n'
# delete empty files
find -type f -empty -delete
printf 'Deleting files which were solved by HQSpre\n'
# delete those files which contain 'p cnf 0'
find -type f -exec fgrep -q  'p cnf 0' '{}' ';' -delete		
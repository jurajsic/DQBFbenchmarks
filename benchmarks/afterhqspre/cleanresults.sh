#!/bin/bash

# Cleanser of the log files from benchexec run on HQSpre to make them normal DQDIMACS files
# Run as
#    ./cleanresults.sh DIR
# or 
#    ./cleanresults.sh -p DIR
# where DIR is the directory with the log files to clean. The cleanser will also remove 
# files which were solved by HQSpre and if -p option is set, cleanser will output the path
# to files which were not solved by HQSpre instead of the log information.

if [[ $# -ne 1 ]]; then
	if [[ $# -ne 2 ]]; then
    	printf 'Wrong number of arguments, run "./cleanresults.sh --help" for help\n'
    	exit 2
	fi
	if [[ $1 != '-p' ]]; then
		print 'Wrong arguments, run "./cleanresults.sh --help" for help\n'
		exit 2
	fi
fi

if [[ $# -ne 2 ]]; then
	if [[ $1 = '--help' || $1 = '-h' ]]; then
	    printf 'Cleanser of the log files from benchexec run on HQSpre to make them normal DQDIMACS files
Run as
    ./cleanresults.sh DIR
or 
    ./cleanresults.sh -p DIR
where DIR is the directory with the log files to clean. The cleanser will also remove 
files which were solved by HQSpre and if -p option is set, cleanser will output the path
to files which were not solved by HQSpre instead of the log information.
'
	    exit 0
	fi
	# go to directory in which are the files to clean
	cd $1
fi

if [[ $# -ne 1 ]]; then
	# go to directory in which are the files to clean
	cd $2
fi


if [[ $# -ne 2 ]]; then
	printf 'Removing ".log" from the end of filenames\n'
fi
rename 's/.{4}$//' *

if [[ $# -ne 2 ]]; then
	printf 'Removing "pipebetteroptions." from the beginning of the filenames\n'
fi
rename 's/^.{18}//' *

if [[ $# -ne 2 ]]; then
	printf 'Deleting files for which HQSpre TIMEOUTed or was OUT OF MEMORY\n'
fi
# delete empty files
find -type f -empty -delete

if [[ $# -ne 2 ]]; then
	printf 'Deleting files which were solved by HQSpre\n'
fi
# delete those files which contain 'p cnf 0'
find -type f -exec fgrep -q  'p cnf 0' '{}' ';' -delete	

if [[ $# -ne 1 ]]; then
	# print out files which were not solved by HQSpre (i.e. print last word on the first line of each log file)
    
    # get the filenames, but starting with "benchmarks/original/....."
	filenames=$(head -q -n1 * | rev | cut -d" " -f 1 | rev)
    # change them to "../original/....." and print them
    echo "${filenames//benchmarks/..}"
fi

if [[ $# -ne 2 ]]; then
	printf 'Deleting the first 6 lines in each file added by benchexec\n'
fi
sed -i '1,6d' *	
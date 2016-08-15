#!/bin/bash
# 20160815 (c) Stefan Sticht

ver=""
host=`hostname`
kernel=`uname -r`
if [ -e /etc/redhat-release ]; then ver=`head -1 /etc/redhat-release`
elif type lsb_release > /dev/null 2>&1 ; then ver=`lsb_release -d`; ver=${ver#*:}; ver=${ver#"${ver%%[![:space:]]*}"}
fi

echo "0 Info - $host $ver $kernel"


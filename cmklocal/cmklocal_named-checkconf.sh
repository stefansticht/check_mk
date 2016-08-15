#!/bin/bash

if type named-checkconf > /dev/null
then
    statusfile=/var/log/named/named-checkconf.lastcheck

    dir=$(dirname "${statusfile}")
    if [ ! -d $dir ]; then mkdir -p $dir >/dev/null; fi
    
    named-checkconf -z > $statusfile 2>/dev/null
    if [ $? -eq 0 ]; then
        status=0
    
        if [ -s $statusfile ]; then
            loaded=$(grep "loaded" $statusfile | wc -l)
            probs=$(grep -v -e "loaded" -e "using RFC1035 TTL semantics" $statusfile | wc -l)
            statustxt="named-checkconf -z syntax check ok, ${loaded} master zone files ok, ${probs} warnings/problems (see $statusfile)"
        else
            statustxt="named-checkconf -z syntax check ok"
        fi
    else
        status=2
    
        if [ -s $statusfile ]; then
            failed=`grep failed $statusfile | wc -l`
            statustxt="named-checkconf -z syntax check failed, ${failed} zone(s) failing to load"
        else
            statustxt="named-checkconf -z syntax check failed - please check ASAP"
        fi
    fi
    echo "$status named-checkconf - $statustxt"
fi

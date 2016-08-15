#!/bin/bash
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# 20160815 Stefan at Sticht.net

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

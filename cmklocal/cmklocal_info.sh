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

ver=""
host=`hostname`
kernel=`uname -r`
if [ -e /etc/redhat-release ]; then ver=`head -1 /etc/redhat-release`
elif type lsb_release > /dev/null 2>&1 ; then ver=`lsb_release -d`; ver=${ver#*:}; ver=${ver#"${ver%%[![:space:]]*}"}
fi

echo "0 Info - $host $ver $kernel"


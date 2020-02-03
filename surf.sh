#!/bin/sh

# path:       ~/projects/surf/surf.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/surf
# date:       2020-02-03T13:49:55+0100

xidfile="/tmp/surf/tabbed-surf.xid"
uri=""

if [ ! -d /tmp/surf ]; then
    mkdir -p "/tmp/surf"
fi

if [ "$#" -gt 0 ]; then
    uri="$1"
fi

runtabbed() {
    tabbed -cdn tabbed-surf -r 2 surf -e '' "$uri" >"$xidfile" 2>/dev/null &
}

if [ ! -r "$xidfile" ];
then
    runtabbed
else
    xid=$(cat "$xidfile")
    if xprop -id "$xid" >/dev/null 2>&1;
    then
        surf -e "$xid" "$uri" >/dev/null 2>&1 &
    else
        runtabbed
    fi
fi

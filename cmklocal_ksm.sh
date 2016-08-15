#!/bin/bash

pages_shared=""
pages_sharing=""
pages_unshared=""

if [ -r /sys/kernel/mm/ksm/pages_shared ] ; then 

    pages_shared=$(tail -1 /sys/kernel/mm/ksm/pages_shared)
    if [ -r /sys/kernel/mm/ksm/pages_sharing ] ; then pages_sharing=$(tail -1 /sys/kernel/mm/ksm/pages_sharing); fi
    if [ -r /sys/kernel/mm/ksm/pages_unshared ] ; then pages_unshared=$(tail -1 /sys/kernel/mm/ksm/pages_unshared); fi

    if [ $pages_shared != "" ] ; then
        pages_saved=$(( pages_sharing - pages_shared ))
        pagesize=$(getconf PAGE_SIZE)
        mbytes_saved=$(( pages_saved * pagesize / 1048576))
        echo "0 Kernel_Samepage_Merging pages_shared=$pages_shared|pages_saved=$pages_saved|pages_unshared=$pages_unshared|mbytes_saved=$mbytes_saved $pages_shared pages shared saving $pages_saved pages ($mbytes_saved MiB); $pages_unshared unique pages cannot be shared"
    fi
fi


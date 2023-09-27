#!/bin/bash

libmalloc="/usr/lib/libtcmalloc.so"

if [ ! -f "$libmalloc" ]; then
    echo "$libmalloc not found"
    exit 1
fi

# This does not turn on heap profiling; it just inserts the code. For that
# reason, it's practical to just always link -ltcmalloc into a binary while
# developing; that's what we do at Google. (However, since any user can turn on
# the profiler by setting an environment variable, it's not necessarily
# recommended to install profiler-linked binaries into a production, running
# system.)

env LD_PRELOAD="$libmalloc" "$@"

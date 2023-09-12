#!/bin/bash

# Replace the path to a required library:
# patchelf --replace-needed ../libsomething1.so /foo/bar/libsomething1.so mysharedobject.so
for file in *.so
do
    ldd $file | grep "not found"
done

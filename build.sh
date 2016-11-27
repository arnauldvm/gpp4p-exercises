#!/bin/bash

tgtdir=./target

mkdir -p "$tgtdir/build"
#git worktree add -f 
#cd "$tgtdir"

git archive --format=zip -9 -o $tgtdir/gpp4p-apps.zip master:apps

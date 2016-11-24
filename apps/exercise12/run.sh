#!/bin/bash
pushd ..
. setenv.sh
popd

ts=$(date +%Y%m%d-%H%M%S)
mkdir -p target/profiles
prof_file=target/profiles/profile-$ts.txt

prof_opt="-Xprof"
(set -x; java $prof_opt -classpath target/classes com.kodewerk.profile.CheckIntegerTestHarness | tee $prof_file)

echo $prof_file

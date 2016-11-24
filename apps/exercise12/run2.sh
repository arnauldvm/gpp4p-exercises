#!/bin/bash
pushd ..
. setenv.sh
popd

ts=$(date +%Y%m%d-%H%M%S)
mkdir -p target/profiles
prof_file=target/profiles/profile-$ts.hprof.txt

#prof_opt="-agentlib:hprof=cpu=samples,depth=100,interval=20,lineno=y,thread=y,file=out.hprof"
prof_opt="-agentlib:hprof=cpu=samples,file=$prof_file"
#prof_opt="-agentlib:hprof=cpu=times,file=$prof_file" # Very slow!
(set -x; java $prof_opt -classpath target/classes com.kodewerk.profile.CheckIntegerTestHarness > $prof_file.out)

tail -30 $prof_file
cat $prof_file.out

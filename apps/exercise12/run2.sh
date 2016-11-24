#!/bin/bash
pushd ..
. setenv.sh
popd

ts=$(date +%Y%m%d-%H%M%S)
mkdir -p target/profiles
prof_file=target/profiles/profile-$ts.hprof.txt
out_file=target/profiles/out-$ts.txt

#prof_opt="-agentlib:hprof=cpu=samples,depth=100,interval=20,lineno=y,thread=y,file=out.hprof"
prof_opt="-agentlib:hprof=cpu=samples,file=$prof_file"
#prof_opt="-agentlib:hprof=cpu=times,file=$prof_file" # Very slow!
(set -x; java $prof_opt -classpath target/classes com.kodewerk.profile.CheckIntegerTestHarness | tee $out_file)

tail -40 $prof_file
echo $prof_file

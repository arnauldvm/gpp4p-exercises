#!/bin/bash
pushd ..
. setenv.sh
popd

function usage() {
	echo "Usage: $0 [ r | c | x | h ]"
	echo "  r: run alone"
	echo "  c: print compilation"
	echo "  X: Xprof profiler"
	echo "  h: hprof profiler"
}

if [ "$#" -ne 1 ]; then
	usage
	exit 1
fi

case "$1" in
	r|c|X|h) ;;
	*) usage; exit 1 ;;
esac

ts=$(date +%Y%m%d-%H%M%S)
mkdir -p target/profiles
prof_file=target/profiles/profile-$ts.txt
out_file="$prof_file"

if [ "$1" = "c" ]; then
	prof_opt="-XX:+PrintCompilation"
fi

if [ "$1" = "X" ]; then
	prof_opt="-Xprof"
fi

if [ "$1" = "h" ]; then
	out_file=target/profiles/out-$ts.txt

	prof_opt="-agentlib:hprof=cpu=samples,file=$prof_file"
	#prof_opt="-agentlib:hprof=cpu=times,file=$prof_file" # Very slow!
fi

(set -x; java $prof_opt -classpath target/classes com.kodewerk.profile.CheckIntegerTestHarness | tee $out_file)

if [ "$1" = "h" ]; then
	tail -40 $prof_file
fi
echo $prof_file

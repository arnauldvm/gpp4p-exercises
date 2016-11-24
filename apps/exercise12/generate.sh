#!/bin/bash
pushd ..
. setenv.sh
popd

java -classpath target/classes com.kodewerk.profile.GenerateData 5000000

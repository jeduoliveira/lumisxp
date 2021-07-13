#!/bin/sh
. ./setclasspath.sh
"$JAVA_HOME"/bin/java -Xmx500m -classpath "$CLASSPATH" lumis.initializeportal.GenerateSql -d:"$LUMIS_HOME"/lumisdata

#!/bin/bash

 ./sbin/start-master.sh
 export PYSPARK_PYTHON=/Users/dimitargueorguiev/git/spark/python/env/bin/python
 export SPARK_HOME=$PWD
 export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
 export PYSPARK_DRIVER_PYTHON='jupyter'
 export PYSPARK_DRIVER_PYTHON_OPTS='notebook --no-browser --port=8889'
 pyspark --packages graphframes:graphframes:0.8.2-spark3.2-s_2.12

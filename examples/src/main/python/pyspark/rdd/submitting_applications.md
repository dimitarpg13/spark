# Submitting Applications

The `spark-submit` script in Spark's `bin` directory is used to launch applications on a cluster. It can use all of Spark's supported cluster managers through a uniform interface so you don't have to configure your application especially for each one.

## Bundling Your Application's Dependencies

If your code depends on other projects, you will need to package them alongside your application in order to distribute the code to a Spark cluster. To do this, create an assembly jar (or "uber" jar) containing your code and its dependencies. Both `sbt` and `Maven` have assembly plugins. When creating assembly jars, list Spark and Hadoop as `provided` dependencies; these need not be bundled since they are provided by the cluster manager at runtime. Once you have assembled jar you can call the `bin/spark-submit` script as shown here while passing your jar.

For Python, you can use the `--py-files` argument of `spark-submit` to add `.py`, `.zip`, or `.egg` files to be distributed with your application. If you depend on multiple Python files we recommend packaging them into a `.zip` or `.egg`. 

## Launching Applications with `spark-submit`

Once a user application is bundled, it can be launched using the `bin/spark-submit` script. The script takes care of setting up the classpath with Spark and its dependencies, and can support different cluster managers and deploy modes that Spark supports:

```python
./bin/spark-submit \
--class <main-class> \
--master <master-url> \
--deploy-mode <deploy-mode> \
--conf <key>=<value> \
... # other options
<application-jar> \
[application-arguments]
```

Some of the commonly used options are:

* `--class`: The entry point for your application (e.g. `org.apache.spark.examples.SparkPi`)
* `--master`: The master URL for the cluster (e.g. `spark://23.195.26.187:7077`)
* `--deploy-mode`: Whether to deploy your driver on the worker nodes (`cluster`) or locally as an external client (`client`) (default: `client`)
* `--conf`: Arbitrary Spark configuration property n `key=value` format. For values that contain spaces wrap "key=value" in quotes. Multiple configurations should be passed as separate arguments. (e.g. `--conf <key>=<value> --conf <key2>=<value2>`)
* `application-jar`: Path to a bundled jar including your application and all dependencies. The URL must be globally visible inside the cluster. For instance `hdfs://` path or a `file://` path that is present on all nodes.
* `application-arguments`: arguments passed to the main method of your main class, if any

A common deployment strategy is to submit your application from a gateway machine that is physically co-located with your worker machines (e.g. Master node in a standalone EC2 cluster). In this setup, `client` mode is appropriate. In `client` mode, the driver is launched directly within the `spark-submit` process whcih acts as a _client_ to the cluster. The input and output of the application is attached to the console. Thus, this mode is especially suitable for applications that
involve the REPL (e.g. Spark shell).

Alternatively, if your application is submitted from a machine far from the worker machines (e.g. locally on your laptop), it is common to use `cluster` mode to minimize network latency between the drivers and the executors. Currently, the standalone mode does not support cluster mode for Python applications.



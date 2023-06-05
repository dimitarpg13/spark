# Hadoop SequenceFile

## What is a SequenceFile in Hadoop

A _SequenceFile_ is a flat, binary file type that serves as a container for data to be used in Hadoop distributed computing applications. _SequenceFile_'s are used extensively with _MapReduce_.

Since Hadoop functions best with larger files, _SequenceFile_'s are used to store and compress files that are smaller than the optimum size for operating efficiently with Hadoop. which can help reduce required disk space capacity and I/O requirements.

_SequenceFile_ serves as a container for a sequence of files. Keys are listed for reference and values, and the contents of the file is referenced in a given key. _SequenceFile_ supports _Writer_, _Reader_ and a _Sorter_ class for respective functions in relation to keys. As an example, a _SequenceFile_ might contain a massive number of log files for a server where the key would be a timestamp and the value would be the entire log file. Normally, the small text files would be very inefficient in Hadoop. After packaging into _SequenceFile_'s, however, they can be used effectively.

Beyond packaging files into a manageable size for Hadoop, _SequenceFile_ supports compression of the keys, the values or both. When both are compressed, the file keys and values are collected into blocks and separately compressed. The type of compression chosen determines the file format.

## The Small File problem and application of SequenceFile for solving it in HDFS and MapReduce

### In HDFS

* _SequenceFile_ is one of the solutions to the small file problem in Hadoop
* Small files are usually significantly smaller than the HDFS block size (128 MB)
* Each file, directory, block in HDFS is represented as object and occupies 150 bytes
* 10 million file would use about 3 GB of memory of a NameNode while a billion files are not feasible

### In MapReduce

* Map tasks usually process a block of input at a time (using the default _FileInputFormat_)
* The larger the number of files is the larger the number of Map tasks needed and as a result the job time can be much slower

### Two Cases Of Small File Scenarios

* The files are pieces of a larger logical file
* The files are inherently small (for example images)

These two cases require different solutions.
* For the first one, write a program to concatenate the small files together
* For the second one, some kind of container is needed to group the files in some way

### Solutions in Hadoop


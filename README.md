# About
Simple project to test out Apache Spark using the Ruby-Spark gem

Based on the documentation from http://ondra-m.github.io/ruby-spark/


# Data from StackExchange

 * https://archive.org/details/stackexchange
 * save to Posts.xml (estimate 30G unzipped)


# Line count from `wc`
```
time wc -l Posts.xml 
21736596 Posts.xml

real	1m50.596s
user	0m0.142s
sys	0m53.081s

=> 1:50s
```


# Line count from Ruby
```
count = File.foreach('Posts.xml').inject(0) {|c, line| c+1}

=> #<Benchmark::Tms:0x00000001acb0d8
 @cstime=0.0,
 @cutime=0.0,
 @label="",
 @real=197.18316774099912,
 @stime=57.400000000000006,
 @total=115.85999999999999,
 @utime=58.45999999999998>
 
=> 3:16s
```


# Line count from Spark

## Install Spark
Follow direction from:
http://ondra-m.github.io/ruby-spark/

## Initial Results
``` log
15/09/08 13:22:18 INFO scheduler.TaskSetManager: Finished task 1.0 in stage 10.0 (TID 923) in 1092 ms on localhost (1/1000)
15/09/08 13:26:41 INFO scheduler.TaskSetManager: Finished task 998.0 in stage 10.0 (TID 1920) in 756 ms on localhost (1000/1000)

count: 21736597

=> 263.0 = 4:22s

sum => 21736625
=> #<Benchmark::Tms:0x00000001c84528 
 @cstime=0.0,
 @cutime=0.0,
 @label="",
 @real=263.18478899600086, 
 @stime=75.25999999999999, 
 @total=205.81, 
 @utime=130.55>
```

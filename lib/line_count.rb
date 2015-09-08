require 'pry'
require 'yaml'
require 'benchmark'

class LineCount
  def run(src_path, worker_count)
    Spark.start

    sc = Spark.sc

    full_path = File.expand_path(src_path)
    text_file = sc.text_file(full_path, worker_count)


    count(text_file)
  end

  def count(text_file)

    word_counter = lambda do |iterator|

      [iterator.size]
    end

    reducer = lambda do |iterator|

      [iterator.reduce(:+)]
    end

    # Every node calculate word count on own collection
    rdd = text_file.map_partitions(word_counter)

    # Set worker count to 1
    # rdd = rdd.coalesce(1)

    # Reduce all prev results
    rdd = rdd.map_partitions(reducer)

    reduced = rdd.collect # => [["127.0.0.1", 1], ["localhost", 1], ["#", 3], ...]

    sum = reduced.reduce(:+)
    $stderr.puts "sum => #{sum}"
  end
end

=begin
load 'lib/line_count.rb'; Benchmark.measure {LineCount.new.run('parts/', 100)}
=end

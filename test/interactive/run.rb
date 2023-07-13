require_relative '../../init'

require 'test_bench/run'
require 'test_bench/run/controls'

Controls = TestBench::Run::Controls

puts <<~TEXT

Run
= = =

TEXT

puts <<~TEXT

Failure
- - -
TEXT

directory = Controls::Directory::Create.()
file_1 = Controls::File::Create::Pass.(directory: directory)
file_2 = Controls::File::Create::Pass.(directory: directory)
file_3 = Controls::File::Create::Crash.(directory: directory)

result = TestBench::Run.(directory)

puts <<~TEXT
Result: #{result.inspect}

TEXT

::File.unlink(file_3)

puts <<~TEXT

Pass
- - -
TEXT

result = TestBench::Run.(directory)

puts <<~TEXT
Result: #{result.inspect}

TEXT

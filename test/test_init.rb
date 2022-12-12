require_relative '../init'

require 'test_bench/isolated'; TestBenchIsolated::TestBench.activate

require 'test_bench/run/controls'

include TestBench

Controls = TestBench::Run::Controls rescue nil

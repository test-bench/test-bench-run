ENV['BOOTSTRAP'] ||= 'on'

require_relative '../init'

if ENV['BOOTSTRAP'] == 'on'
  require 'test_bench/bootstrap'; TestBench::Bootstrap.activate
else
  require 'test_bench'; TestBench.activate
end

require 'test_bench/run/controls'

include TestBench

Controls = TestBench::Run::Controls rescue nil

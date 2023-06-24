require_relative 'interactive_init'

puts <<~TEXT

Serial Executor
= = =
TEXT

if not ENV.key?('ITERATIONS')
  iterations = 111
  puts "\e[3m(ITERATIONS isn't set, default is #{iterations})\e[23m"
else
  iterations = ENV.fetch('ITERATIONS').to_i
end
puts "Iterations: #{iterations}"
puts

if not ENV.key?('FAILURES')
  failures = true
  puts "\e[3m(FAILURES isn't set, default is #{failures})\e[23m"
else
  failures = ENV.fetch('FAILURES') != "off"
end
puts "Iterations: #{iterations}"
puts


file = Controls::File::Create.(contents: <<~RUBY)
comment "File executed (File: \#{__FILE__.inspect}, Process ID: \#{::Process.pid})"

if #{failures} && TestBench::Run::Controls::Random.integer % 4 == 0
  raise "Error during test"
end

sleep 0.001
RUBY

executor = Run::Executor::Serial.build

executor.start

iterations.times do |i|
  executor.execute(file)
end

executor.finish

puts <<~TEXT

Passed: #{Session::Store.fetch.passed?}
Failed: #{Session::Store.fetch.failed?}
- - -
(done)

TEXT

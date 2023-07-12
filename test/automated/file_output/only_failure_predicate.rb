require_relative '../automated_init'

context "File Output" do
  context "Only Failure Predicate" do
    original_env = ENV.to_h
    ENV.clear

    context "TEST_BENCH_ONLY_FAILURE Isn't Set" do
      output = Run::Output::File.new

      only_failure = output.only_failure?

      comment only_failure.inspect

      test "Not activated" do
        refute(only_failure)
      end
    end

    context "TEST_BENCH_ONLY_FAILURE Is Set" do
      context "Activated" do
        ENV['TEST_BENCH_ONLY_FAILURE'] = 'on'

        output = Run::Output::File.new

        only_failure = output.only_failure?

        comment only_failure.inspect
        detail "TEST_BENCH_ONLY_FAILURE: #{ENV['TEST_BENCH_ONLY_FAILURE'].inspect}"

        test "Activated" do
          assert(only_failure)
        end
      end

      context "Deactivated" do
        ENV['TEST_BENCH_ONLY_FAILURE'] = 'off'

        output = Run::Output::File.new

        only_failure = output.only_failure?

        comment only_failure.inspect
        detail "TEST_BENCH_ONLY_FAILURE: #{ENV['TEST_BENCH_ONLY_FAILURE'].inspect}"

        test "Not activated" do
          refute(only_failure)
        end
      end
    end

  ensure
    ENV.replace(original_env)
  end
end

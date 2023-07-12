require_relative '../../automated_init'

context "Run" do
  context "Variant" do
    context "Started" do
      run = Run.new

      control_random_seed = Controls::Events::Started.random_seed
      run.random.set_seed(control_random_seed)

      path = Controls::Path.example

      executor = run.executor

      executor_started = nil
      started = nil

      run.! do
        run.path(path)

        executor_started = executor.started?
        started = run.telemetry.one_event(Run::Events::Started)
      end

      test "Executor is started" do
        assert(executor_started)
      end

      context "Started Event" do
        test! "Recorded" do
          refute(started.nil?)
        end

        context "Attributes" do
          context "Random Seed" do
            random_seed = started.random_seed

            comment random_seed.inspect
            detail "Control: #{random_seed.inspect}"

            test do
              assert(random_seed == control_random_seed)
            end
          end
        end
      end
    end
  end
end

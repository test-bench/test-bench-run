require_relative '../../automated_init'

context "Run" do
  context "Variant" do
    context "Finished Event" do
      run = Run.new

      control_random_seed = Controls::Events::Finished.random_seed
      run.random.set_seed(control_random_seed)

      executor = run.executor

      path = Controls::Path.example

      control_result = Controls::Result.pass

      run.! do
        run.path(path)

        run.session.record_assertion

        refute(executor.finished?)
        refute(run.telemetry.one_event?(Run::Events::Finished))
      end

      executor_finished = executor.finished?

      test "Executor is finished" do
        assert(executor_finished)
      end

      context "Finished Event" do
        finished = run.telemetry.one_event(Run::Events::Finished)

        test! "Recorded" do
          refute(finished.nil?)
        end

        context "Attributes" do
          context "Result" do
            result = finished.result

            comment result.inspect
            detail "Control: #{control_result.inspect}"

            test do
              assert(result == control_result)
            end
          end

          context "Random Seed" do
            random_seed = finished.random_seed

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

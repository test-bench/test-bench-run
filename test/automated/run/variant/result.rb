require_relative '../../automated_init'

context "Run" do
  context "Variant" do
    context "Result" do
      path = Controls::Path.example

      context "Session Passed" do
        control_result = Controls::Result.pass

        run = Run.new

        result = run.! do
          run.path(path)

          run.session.record_assertion
        end

        context "Result" do
          comment result.inspect

          detail "Control: #{control_result.inspect}"

          test do
            assert(result == control_result)
          end
        end
      end

      context "Session Failed" do
        control_result = Controls::Result.failure

        run = Run.new

        result = run.! do
          run.path(path)

          run.session.record_failure
        end

        context "Result" do
          comment result.inspect

          detail "Control: #{control_result.inspect}"

          test do
            assert(result == control_result)
          end
        end
      end

      context "Session Contained Skipped Tests Or Contexts" do
        run = Run.new

        result = run.! do
          run.path(path)

          run.session.record_skip
        end

        context "Result" do
          comment result.inspect

          test "Didn't pass" do
            refute(!!result)
          end
        end
      end
    end
  end
end

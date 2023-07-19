require_relative '../../automated_init'

context "Run" do
  context "Substitute" do
    context "Pass" do
      run = Run::Substitute.build

      control_result = Controls::Result.pass
      run.set_result(control_result)

      path = Controls::Path.example
      result = run.(path)

      context "Result" do
        comment result.inspect
        detail "Control: #{control_result.inspect}"

        test do
          assert(result == control_result)
        end
      end
    end

    context "Failure" do
      run = Run::Substitute.build

      control_result = Controls::Result.failure
      run.set_result(control_result)

      path = Controls::Path.example
      result = run.(path)

      context "Result" do
        comment result.inspect
        detail "Control: #{control_result.inspect}"

        test do
          assert(result == control_result)
        end
      end
    end
  end
end

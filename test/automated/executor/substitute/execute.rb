require_relative '../../automated_init'

context "Executor" do
  context "Substitute" do
    context "Execute" do
      substitute = Run::Executor::Substitute.build

      file = Controls::File.example

      refute(substitute.executed?)

      substitute.execute(file)

      context "Executed" do
        executed = substitute.executed?(file)

        test do
          assert(executed)
        end
      end

      context "Other File" do
        other_file = Controls::File.random

        executed = substitute.executed?(other_file)

        test "Not executed" do
          refute(executed)
        end
      end

      context "No File" do
        executed = substitute.executed?

        test "Executed" do
          assert(executed)
        end
      end
    end
  end
end

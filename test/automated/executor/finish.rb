require_relative '../automated_init'

context "Executor" do
  context "Finish" do
    context "Implemented" do
      executor = Controls::Executor.example

      executor.finish

      test do
        assert(executor.finished?)
      end
    end

    context "Not Implemented" do
      executor = Controls::Executor::NotImplemented.example

      test "Isn't an error" do
        refute_raises(Run::Executor::AbstractMethodError) do
          executor.finish
        end
      end
    end
  end
end


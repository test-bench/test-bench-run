require_relative '../automated_init'

context "Executor" do
  context "Start" do
    context "Implemented" do
      executor = Controls::Executor.example

      executor.start

      test do
        assert(executor.started?)
      end
    end

    context "Not Implemented" do
      executor = Controls::Executor::NotImplemented.example

      test "Isn't an error" do
        refute_raises(Run::Executor::AbstractMethodError) do
          executor.start
        end
      end
    end
  end
end

require_relative '../automated_init'

context "Executor" do
  context "Execute" do
    file = Controls::File.example

    context "Implemented" do
      executor = Controls::Executor.example

      refute(executor.executed?(file))

      executor.execute(file)

      test do
        assert(executor.executed?(file))
      end
    end

    context "Not Implemented" do
      executor = Controls::Executor::NotImplemented.example

      test "Is an error" do
        assert_raises(Run::Executor::AbstractMethodError) do
          executor.execute(file)
        end
      end
    end
  end
end

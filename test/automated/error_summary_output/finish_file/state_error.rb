require_relative '../../automated_init'

context "Error Summary Output" do
  context "Finish File" do
    context "State Error" do
      file = Controls::File.example
      result = Controls::Result.example

      context "Different Current File" do
        output = Run::Output::Summary::Error.new

        other_file = Controls::File.random
        output.start_file(other_file)

        test "Is an error" do
          assert_raises(Run::Output::Summary::Error::StateError) do
            output.finish_file(file, result)
          end
        end
      end

      context "No Current File" do
        output = Run::Output::Summary::Error.new

        test "Is an error" do
          assert_raises(Run::Output::Summary::Error::StateError) do
            output.finish_file(file, result)
          end
        end
      end
    end
  end
end

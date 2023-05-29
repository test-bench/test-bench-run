require_relative '../../automated_init'

context "Error Summary Output" do
  context "Finish File" do
    file = Controls::File.example
    result = Controls::Result.example

    output = Run::Output::Summary::Error.new
    output.start_file(file)

    output.finish_file(file, result)

    context "Current File" do
      reset = !output.current_file?

      test "Reset" do
        assert(reset)
      end
    end
  end
end

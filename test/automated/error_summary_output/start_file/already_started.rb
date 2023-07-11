require_relative '../../automated_init'

context "Error Summary Output" do
  context "Start File" do
    context "Already Started" do
      output = Run::Output::Summary::Error.new

      control_file = Controls::File.random
      output.start_file(control_file)

      file = Controls::File.example

      test "Is an error" do
        assert_raises(Run::Output::Summary::Error::StateError) do
          output.start_file(file)
        end
      end
    end
  end
end

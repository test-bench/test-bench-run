require_relative '../../automated_init'

context "Error Summary Output" do
  context "Handle File Finished Event" do
    output = Run::Output::Summary::Error.new

    file = Controls::File.example

    file_started = Controls::Events::FileStarted.example(file:)
    output.handle(file_started)

    file_finished = Controls::Events::FileFinished.example(file:)
    output.handle(file_finished)

    context "Current File" do
      current_file = output.current_file

      comment current_file.inspect

      reset = current_file.nil?

      test "Reset" do
        assert(reset)
      end
    end
  end
end

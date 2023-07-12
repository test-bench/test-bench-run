require_relative '../automated_init'

context "Error Summary Output" do
  context "Handle File Started Event" do
    output = Run::Output::Summary::Error.new

    file = Controls::File.random

    file_started = Controls::Events::FileStarted.example(file:)
    output.handle(file_started)

    context "Current File" do
      updated = output.current_file?(file)

      test "Updated" do
        assert(updated)
      end
    end
  end
end

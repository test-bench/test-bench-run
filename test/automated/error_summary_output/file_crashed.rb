require_relative '../automated_init'

context "Error Summary Output" do
  context "Handle File Crashed Event" do
    output = Run::Output::Summary::Error.new

    file = Controls::File.example

    file_started = Controls::Events::FileStarted.example(file:)
    output.handle(file_started)

    control_error_message = Controls::Exception::Message.example
    file_crashed = Controls::Events::FileCrashed.example(file:, error_message: control_error_message)
    output.handle(file_crashed)

    context "Failure Summary" do
      failure_summary = output.failure_summary

      context "Entry for file" do
        entry = failure_summary[file]

        comment entry.inspect

        test! do
          refute(entry.nil?)
        end

        context "Error Message" do
          error_message = entry.error_message

          comment error_message.inspect
          detail "Control: #{control_error_message.inspect}"

          test do
            assert(error_message == control_error_message)
          end
        end
      end
    end

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

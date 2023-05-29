require_relative '../../automated_init'

context "Error Summary Output" do
  context "Finish File" do
    context "Failure" do
      file = Controls::File.example

      context "Test Failure" do
        result = Controls::Result.failure

        output = Run::Output::Summary::Error.new
        output.start_file(file)

        control_entry = output.current_file

        output.finish_file(file, result)

        context "Failure Summary" do
          failure_summary = output.failure_summary

          context "Entry for file" do
            entry = failure_summary[file]

            comment entry.inspect
            detail "Control: #{control_entry.inspect}"

            test do
              assert(entry == control_entry)
            end
          end
        end
      end

      context "Error" do
        control_error_message = Controls::Exception::Message.example

        output = Run::Output::Summary::Error.new
        output.start_file(file)

        control_entry = output.current_file

        output.finish_file(file, error_message: control_error_message)

        context "Failure Summary" do
          failure_summary = output.failure_summary

          context "Entry for file" do
            entry = failure_summary[file]

            comment entry.inspect
            detail "Control: #{control_entry.inspect}"

            test do
              assert(entry == control_entry)
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
      end
    end
  end
end

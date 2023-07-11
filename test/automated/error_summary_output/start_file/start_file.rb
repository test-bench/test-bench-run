require_relative '../../automated_init'

context "Error Summary Output" do
  context "Start File" do
    output = Run::Output::Summary::Error.new

    control_file = Controls::File.example
    output.start_file(control_file)

    context "Current File" do
      current_file = output.current_file

      test! do
        refute(current_file.nil?)
      end

      context "Attributes" do
        context "File" do
          file = current_file.file

          comment file.inspect
          detail "Control: #{control_file.inspect}"

          test do
            assert(file == control_file)
          end
        end

        context "Failures" do
          failures = current_file.failures

          comment failures.inspect

          test "Zero" do
            assert(failures.zero?)
          end
        end

        context "Error Message" do
          error_message = current_file.error_message

          comment error_message.inspect

          test "Not set" do
            assert(error_message.nil?)
          end
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Error Summary Output" do
  context "Handle Finished Event" do
    context "Error and Failure" do
      result = Controls::Result.failure
      finished = Controls::Events::Finished.example(result:)

      file = Controls::File.example
      error_message = Controls::Exception::Message.example

      output = Run::Output::Summary::Error.new

      current_file = output.start_file(file)
      2.times do
        current_file.record_failure
      end

      output.finish_file(file, error_message:)

      output.handle(finished)

      context "Written Text" do
        writer = output.writer

        written_text = writer.written_text
        control_written_text = <<~TEXT
        Failure Summary:
        - #{file}: 2 failures. File crashed, error:
          #{error_message}

        TEXT

        comment written_text
        detail "Control:", control_written_text

        test do
          assert(writer.written?(control_written_text))
        end
      end
    end
  end
end

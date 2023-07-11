require_relative '../../automated_init'

context "Error Summary Output" do
  context "Handle Finished Event" do
    context "Multiple Files Failed" do
      result = Controls::Result.failure
      finished = Controls::Events::Finished.example(result:)

      file_1 = Controls::File.example
      file_2 = Controls::File.random

      output = Run::Output::Summary::Error.new

      file_record_1 = output.start_file(file_1)
      2.times do
        file_record_1.record_failure
      end
      output.finish_file(file_1, result)

      file_record_2 = output.start_file(file_2)
      2.times do
        file_record_2.record_failure
      end
      output.finish_file(file_2, result)

      output.handle(finished)

      context "Written Text" do
        writer = output.writer

        written_text = writer.written_text
        control_written_text = <<~TEXT
        Failure Summary:
        - #{file_1}: 2 failures

        - #{file_2}: 2 failures

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

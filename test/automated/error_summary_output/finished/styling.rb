require_relative '../../automated_init'

context "Error Summary Output" do
  context "Handle Finished Event" do
    context "Styling" do
      result = Controls::Result.failure
      finished = Controls::Events::Finished.example(result:)

      file = Controls::File.example

      output = Run::Output::Summary::Error.new

      writer = output.writer
      writer.styling!

      current_file = output.start_file(file)
      2.times do
        current_file.record_failure
      end

      output.finish_file(file, result)

      output.handle(finished)

      context "Written Text" do
        written_text = writer.written_text
        control_written_text = <<~TEXT
        \e[1;4;31mFailure Summary:\e[0m
        \e[2;31m-\e[22;1m #{file}\e[22m: 2 failures\e[0m
        \e[0m
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

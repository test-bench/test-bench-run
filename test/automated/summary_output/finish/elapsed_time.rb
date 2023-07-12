require_relative '../../automated_init'

context "Summary Output" do
  context "Finish" do
    context "Elapsed Time" do
      output = Run::Output::Summary.new

      output.tests_finished = 111

      elapsed_time = Controls::Time::Elapsed.example
      output.elapsed_time = elapsed_time

      output.finish

      context "Written Text" do
        writer = output.writer

        written_text = writer.written_text
        control_text = <<~TEXT
        Finished running 0 files, 0 files crashed
        Ran 111 tests in 0.111s (999 tests/second)
        0 passed, 0 skipped, 0 failed

        TEXT

        comment written_text
        detail "Control:", control_text

        test do
          assert(writer.written?(control_text))
        end
      end
    end
  end
end

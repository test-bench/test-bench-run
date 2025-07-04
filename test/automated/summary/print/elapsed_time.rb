require_relative '../../automated_init'

context "Summary" do
  context "Print" do
    context "Elapsed Time" do
      summary = Run::Summary.new

      summary.start_time = Controls::Time.example
      finish_time = Controls::Time.example(offset_milliseconds: 1_000)

      summary.status = Controls::Status.example

      summary.print(finish_time)

      control_text = <<~TEXT
      Attempted 0 files: 0 completed, 0 aborted, 0 not found
      1111 tests in 1.00 seconds (1111.00 tests/sec)
      1000 passed, 111 failed, 11+ skipped

      TEXT

      comment "Printed Text:", summary.writer.written_text
      detail "Control Text:", control_text

      test do
        assert(summary.writer.written?(control_text))
      end
    end
  end
end

require_relative '../../automated_init'

context "Summary" do
  context "Print" do
    context "Singular Values" do
      summary = Run::Summary.new

      summary.file_totals = Controls::Summary::File::Totals.example(
        attempted: 1,
        completed: 1,
        aborted: 1,
        not_found: 1
      )

      summary.status = Controls::Status.example(
        tests: 1,
        failures: 0,
        errors: 1,
        skipped: 1
      )

      summary.print

      context "No file summary" do
        control_text = <<~TEXT
        Attempted 1 file: 1 completed, 1 aborted, 1 not found
        1 test in 0.00 seconds (Inf tests/sec)
        1 passed, 0 failed, 1+ skipped

        TEXT

        comment "Printed Text:", summary.writer.written_text
        detail "Control Text:", control_text

        test do
          assert(summary.writer.written?(control_text))
        end
      end
    end
  end
end

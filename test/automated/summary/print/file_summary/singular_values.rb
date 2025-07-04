require_relative '../../../automated_init'

context "Summary" do
  context "Print" do
    context "File Summary" do
      context "Singular Values" do
        summary = Run::Summary.new

        aborted = Controls::Session::Events::Aborted.example

        file_info = Controls::Summary::File::Info.example(
          tests: 1,
          failures: 1,
          skipped: 1,
          aborted_events: [aborted]
        )

        summary.add_file(file_info)

        summary.print

        control_text = <<~TEXT
        File Summary
        - - -
        - #{file_info.file_path}: 1 failure, 1+ skipped, 1 error:
          #{aborted.message}
          #{aborted.location}

        #{Controls::Summary::Run::Initial.unstyled}
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

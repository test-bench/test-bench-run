require_relative '../../../automated_init'

context "Summary" do
  context "Print" do
    context "File Summary" do
      context "No Tests" do
        file_info = Controls::Summary::File::Info.example(
          tests: 0,
          failures: 0,
          skipped: 0,
          aborted_events: []
        )

        context "Styling Enabled" do
          summary = Run::Summary.new

          summary.writer.set_styling

          summary.add_file(file_info)

          summary.print

          control_text = <<~TEXT
          \e[1;4mFile Summary\e[m
          \e[2m-\e[22m \e[1m#{file_info.file_path}\e[22m: \e[2;3mno tests\e[23;22m\e[m
          \e[m
          #{Controls::Summary::Run::Initial.styled}\e[m
          TEXT

          comment "Printed Text:", summary.writer.written_text
          detail "Control Text:", control_text

          test do
            assert(summary.writer.written?(control_text))
          end
        end

        context "Styling Disabled" do
          summary = Run::Summary.new

          summary.add_file(file_info)

          summary.print

          control_text = <<~TEXT
          File Summary
          - - -
          - #{file_info.file_path}: no tests

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
end

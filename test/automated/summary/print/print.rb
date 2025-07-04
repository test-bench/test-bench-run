require_relative '../../automated_init'

context "Summary" do
  context "Print" do
    file_totals = Controls::Summary::File::Totals.example
    status = Controls::Status.example

    context "Styling Enabled" do
      summary = Run::Summary.new

      summary.writer.set_styling

      Controls::Summary::File::Info::Set.(summary)

      summary.file_totals = file_totals
      summary.status = status

      summary.print

      control_text = Controls::Summary::Styled.example

      comment "Printed Text:", summary.writer.written_text
      detail "Control Text:", control_text

      test do
        assert(summary.writer.written?(control_text))
      end
    end

    context "Styling Disabled" do
      summary = Run::Summary.new

      Controls::Summary::File::Info::Set.(summary)

      summary.file_totals = file_totals
      summary.status = status

      summary.print

      control_text = Controls::Summary::Unstyled.example

      comment "Printed Text:", summary.writer.written_text
      detail "Control Text:", control_text

      test do
        assert(summary.writer.written?(control_text))
      end
    end
  end
end

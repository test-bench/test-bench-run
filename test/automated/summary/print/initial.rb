require_relative '../../automated_init'

context "Summary" do
  context "Print" do
    context "Initial" do
      context "Styling Enabled" do
        summary = Run::Summary.new

        summary.writer.set_styling

        summary.print

        control_text = Controls::Summary::Initial.styled

        comment "Printed Text:", summary.writer.written_text
        detail "Control Text:", control_text

        test do
          assert(summary.writer.written?(control_text))
        end
      end

      context "Styling Disabled" do
        summary = Run::Summary.new

        summary.print

        control_text = Controls::Summary::Initial.unstyled

        comment "Printed Text:", summary.writer.written_text
        detail "Control Text:", control_text

        test do
          assert(summary.writer.written?(control_text))
        end
      end
    end
  end
end

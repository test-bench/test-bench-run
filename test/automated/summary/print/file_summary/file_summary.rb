require_relative '../../../automated_init'

context "Summary" do
  context "Print" do
    context "File Summary" do
      context "Styling Enabled" do
        summary = Run::Summary.new

        summary.writer.set_styling

        Controls::Summary::File::Info::Set.(summary)

        summary.print

        control_text = <<~TEXT
        #{Controls::Summary::File::Styled.example}\e[m
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

        Controls::Summary::File::Info::Set.(summary)

        summary.print

        control_text = <<~TEXT
        #{Controls::Summary::File::Unstyled.example}
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

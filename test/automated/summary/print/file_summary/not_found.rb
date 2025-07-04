require_relative '../../../automated_init'

context "Summary" do
  context "Print" do
    context "File Summary" do
      context "File Not Found" do
        file_info = Controls::Summary::File::Info::NotFound.example

        context "Styling Enabled" do
          summary = Run::Summary.new

          summary.writer.set_styling

          summary.add_file(file_info)

          summary.print

          control_text = <<~TEXT
          \e[1;4m\e[31mFile Summary\e[m
          \e[31m\e[2m-\e[22m \e[1m#{file_info.file_path}\e[22m: file not found\e[m
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
          - #{file_info.file_path}: file not found

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

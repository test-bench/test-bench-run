require_relative '../../automated_init'

context "Summary Output" do
  context "Finish" do
    context "Contexts Skipped" do
      output = Run::Output::Summary.new

      output.tests_skipped = 10
      output.contexts_skipped = 1

      output.finish

      context "Written Text" do
        writer = output.writer

        written_text = writer.written_text
        control_text = <<~TEXT
        Finished running 0 files, 0 files crashed
        Ran 0 tests
        0 passed, 11+ skipped, 0 failed

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

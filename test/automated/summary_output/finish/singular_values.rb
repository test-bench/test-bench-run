require_relative '../../automated_init'

context "Summary Output" do
  context "Finish" do
    context "Singular Values" do
      output = Run::Output::Summary.new

      output.tests_finished = 1
      output.elapsed_time = 1

      output.files_finished = 1
      output.files_crashed = 1

      output.finish

      context "Written Text" do
        writer = output.writer

        written_text = writer.written_text
        control_text = <<~TEXT
        Finished running 1 file, 1 file crashed
        Ran 1 test in 1.000s (1 test/second)
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

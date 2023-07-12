require_relative '../../automated_init'

context "Summary Output" do
  context "Finish" do
    output = Run::Output::Summary.new

    output.files_finished = 11
    output.files_crashed = 12

    output.tests_finished = 111
    output.elapsed_time = Controls::Time::Elapsed.example

    output.tests_passed = 100
    output.tests_skipped = 10
    output.tests_failed = 1

    output.finish

    context "Written Text" do
      writer = output.writer

      written_text = writer.written_text
      control_text = <<~TEXT
      Finished running 11 files, 12 files crashed
      Ran 111 tests in 0.111s (999 tests/second)
      100 passed, 10 skipped, 1 failed

      TEXT

      comment written_text
      detail "Control:", control_text

      test do
        assert(writer.written?(control_text))
      end
    end
  end
end

require_relative '../automated_init'

context "Summary Output" do
  context "Handle Finished Event" do
    output = Run::Output::Summary.new

    start_time = Controls::Time.example
    output.start_time = start_time

    finish_time = Controls::Time::Offset.example
    finished = Controls::Events::Finished.example(time: finish_time)

    output.handle(finished)

    context "Written Text" do
      writer = output.writer

      written_text = writer.written_text
      control_text = <<~TEXT
      Finished running 0 files, 0 files crashed
      Ran 0 tests in 0.111s (0 tests/second)
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

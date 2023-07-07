require_relative '../../automated_init'

context "File Output" do
  context "Handle File Crashed Event" do
    file = Controls::Events::FileCrashed.file
    file_crashed = Controls::Events::FileCrashed.example(file:)

    file_started = Controls::Events::FileStarted.event_data

    commented = Controls::Events::Session::Commented.event_data
    comment_text, * = commented.data

    writer = Session::Output::Writer::Substitute.build
    output = Run::Output::File.build(writer:)

    output.receive(file_started)
    output.receive(commented)

    output.handle(file_crashed)

    context "Written Text" do
      written_text = writer.written_text
      control_written_text = <<~TEXT
      Running #{file}
      #{comment_text}
      TEXT

      comment written_text
      detail "Control:", control_written_text

      test do
        assert(writer.written?(control_written_text))
      end
    end
  end
end

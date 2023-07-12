require_relative '../../automated_init'

context "File Output" do
  context "Handle File Finished Event" do
    context "No Pended Events" do
      file = Controls::File.example
      file_finished = Controls::Events::FileFinished.example(file:)

      file_started = Controls::Events::FileStarted.event_data

      writer = Session::Output::Writer::Substitute.build
      writer.styling!

      output = Run::Output::File.build(writer:)

      output.receive(file_started)

      output.handle(file_finished)

      context "Written Text" do
        written_text = writer.written_text
        control_written_text = <<~TEXT
        Running #{file}\e[0m
        \e[2m(Nothing written)\e[0m
        \e[0m
        TEXT

        comment written_text.inspect
        detail "Control:", control_written_text

        test do
          assert(writer.written?(control_written_text))
        end
      end
    end
  end
end

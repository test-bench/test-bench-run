require_relative '../../automated_init'

context "File Output" do
  context "Handle File Finished Event" do
    context "Failure" do
      result = Controls::Result.failure

      file_finished = Controls::Events::FileFinished.example(result:)

      file_started = Controls::Events::FileStarted.example

      context "Only Failure Mode Isn't Activated" do
        writer = Session::Output::Writer::Substitute.build

        output = Run::Output::File.build(writer:)

        output.handle(file_started)

        output.handle(file_finished)

        context "Written Text" do
          written_text = writer.written_text

          comment written_text

          test do
            assert(writer.written?)
          end
        end
      end

      context "Only Failure Mode Isn't Activated" do
        writer = Session::Output::Writer::Substitute.build

        output = Run::Output::File.build(writer:)
        output.only_failure = true

        output.handle(file_started)

        output.handle(file_finished)

        context "Written Text" do
          written_text = writer.written_text

          comment written_text

          test do
            assert(writer.written?)
          end
        end
      end
    end
  end
end

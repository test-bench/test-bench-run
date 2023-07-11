require_relative '../../automated_init'

context "Error Summary Output" do
  context "Handle Finished Event" do
    context "No Files Run" do
      result = Controls::Result.failure
      finished = Controls::Events::Finished.example(result:)

      output = Run::Output::Summary::Error.new

      output.handle(finished)

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        comment written_text

        test "Nothing written" do
          refute(writer.written?)
        end
      end
    end
  end
end

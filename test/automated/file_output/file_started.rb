require_relative '../automated_init'

context "File Output" do
  context "Handle File Started Event" do
    file_started = Controls::Events::FileStarted.event_data

    output = Run::Output::File.new

    output.handle(file_started)

    context "Started" do
      process_id = file_started.process_id

      started = output.started?(process_id)

      test do
        assert(started)
      end
    end

    context "Not pended" do
      pended = output.pended?(file_started)

      test do
        refute(pended)
      end
    end
  end
end

require_relative '../automated_init'

context "File Output" do
  context "Handle Finished Event" do
    finished = Controls::Events::Finished.event_data

    output = Run::Output::File.new

    output.handle(finished)

    context "Not pended" do
      pended = output.pended?(finished)

      test do
        refute(pended)
      end
    end
  end
end

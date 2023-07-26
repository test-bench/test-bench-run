require_relative '../automated_init'

context "File Output" do
  context "Handle Started Event" do
    started = Controls::Events::Started.event_data

    output = Run::Output::File.new

    output.handle(started)

    context "Not pended" do
      pended = output.pended?(started)

      test do
        refute(pended)
      end
    end
  end
end

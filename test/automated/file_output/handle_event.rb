require_relative '../automated_init'

context "File Output" do
  context "Handle Event" do
    event_data = Controls::EventData.example

    output = Run::Output::File.new

    output.handle(event_data)

    context "Pended" do
      pended = output.pended?(event_data)

      test do
        assert(pended)
      end
    end
  end
end

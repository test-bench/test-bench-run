require_relative '../automated_init'

context "File Output" do
  context "Pend Event" do
    output = Run::Output::File.new

    event_data = Controls::EventData.example

    output.pend(event_data)

    context "Pended" do
      pended = output.pended?(event_data)

      comment pended.inspect

      test do
        assert(pended)
      end
    end
  end
end

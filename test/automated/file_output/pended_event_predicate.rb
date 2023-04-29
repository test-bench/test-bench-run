require_relative '../automated_init'

context "File Output" do
  context "Pended Event Predicate" do
    output = Run::Output::File.new

    process_id = Controls::ProcessID.example
    event_data = Controls::EventData.example(process_id:)

    output.pend(event_data)

    context "Pended" do
      pended = output.pended?(event_data)

      comment pended.inspect

      test do
        assert(pended)
      end
    end

    context "Not Pended" do
      context "Process Hasn't Started" do
        other_event_data = Controls::EventData.random

        pended = output.pended?(other_event_data)

        comment pended.inspect

        test do
          refute(pended)
        end
      end

      context "Process Has Started" do
        other_event_data = Controls::EventData::Random.example(process_id:)

        pended = output.pended?(other_event_data)

        comment pended.inspect

        test do
          refute(pended)
        end
      end
    end
  end
end

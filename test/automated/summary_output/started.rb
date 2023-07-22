require_relative '../automated_init'

context "Summary Output" do
  context "Handle Started Event" do
    time = Controls::Time.example
    started = Controls::Events::Started.example(time:)

    output = Run::Output::Summary.new

    output.handle(started)

    context "Start Time" do
      start_time = output.start_time

      comment start_time.inspect
      detail "Started Time: #{time.inspect}"

      test do
        assert(start_time == time)
      end
    end
  end
end

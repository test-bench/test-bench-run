require_relative '../automated_init'

context "File Output" do
  context "Started Predicate" do
    process_id = Controls::ProcessID.example

    output = Run::Output::File.new

    output.start(process_id)

    context "Started" do
      started = output.started?(process_id)

      test do
        assert(started)
      end
    end

    context "Not Started" do
      output = Run::Output::File.new

      other_process_id = Controls::ProcessID.random

      started = output.started?(other_process_id)

      test do
        refute(started)
      end
    end
  end
end

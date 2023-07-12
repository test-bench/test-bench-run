require_relative '../automated_init'

context "File Output" do
  context "Start" do
    process_id = Controls::ProcessID.example

    context "Not Yet Started" do
      output = Run::Output::File.new

      output.start(process_id)

      started = output.started?(process_id)

      test "Process is started" do
        assert(started)
      end
    end

    context "Already Started" do
      output = Run::Output::File.new

      output.start(process_id)

      test "Is an error" do
        assert_raises(Run::Output::File::Error) do
          output.start(process_id)
        end
      end
    end
  end
end

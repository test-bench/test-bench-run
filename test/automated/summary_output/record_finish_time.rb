require_relative '../automated_init'

context "Summary Output" do
  context "Record Finish Time" do
    control_finish_time = Controls::Time::Offset.example

    context "Start Time Set" do
      output = Run::Output::Summary.new

      start_time = Controls::Time.example
      output.start_time = start_time

      output.record_finish_time(control_finish_time)

      context "Finish Time" do
        finish_time = output.finish_time

        comment finish_time.inspect
        detail "Control: #{control_finish_time.inspect}"

        test "Set" do
          assert(finish_time == control_finish_time)
        end
      end

      context "Elapsed time" do
        elapsed_time = output.elapsed_time
        control_elapsed_time = Controls::Time::Elapsed.example

        comment elapsed_time.inspect
        detail "Control: #{control_elapsed_time.inspect}"

        test "Set" do
          assert(elapsed_time == control_elapsed_time)
        end
      end
    end

    context "Start Time Not Set" do
      output = Run::Output::Summary.new

      test "Is an error" do
        assert_raises(Run::Output::Summary::StateError) do
          output.record_finish_time(control_finish_time)
        end
      end
    end
  end
end

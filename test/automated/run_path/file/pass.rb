require_relative '../../automated_init'

context "Run Path" do
  context "File" do
    context "Pass" do
      run_path = Run::Path.new

      control_file = Controls::File::Pass::Create.()

      run_path.file(control_file)

      context "File Finished Event" do
        file_finished = run_path.telemetry.one_event(Run::Events::FileFinished)

        test! do
          refute(file_finished.nil?)
        end

        context "Result Attribute" do
          result = file_finished.result
          control_result = Controls::Result.pass

          comment result.inspect
          detail "Control: #{control_result.inspect}"

          test do
            assert(result == control_result)
          end
        end
      end
    end
  end
end

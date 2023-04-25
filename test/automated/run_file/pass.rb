require_relative '../automated_init'

context "Run File" do
  context "Pass" do
    run_file = Run::File.new

    control_file = Controls::File::Create::Pass.()

    result = run_file.(control_file)

    test! do
      assert(result)
    end

    context "File Finished Event" do
      file_finished = run_file.session.one_event(Run::Events::FileFinished)

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

require_relative '../automated_init'

context "Run File" do
  context "Failure" do
    run_file = Run::File.new

    session = run_file.session

    control_file = Controls::File::Create::Failure.(session:)

    result = run_file.(control_file)

    test! do
      refute(result)
    end

    context "File Finished Event" do
      file_finished = run_file.session.one_event(Run::Events::FileFinished)

      test! do
        refute(file_finished.nil?)
      end

      context "Result Attribute" do
        result = file_finished.result
        control_result = Controls::Result.failure

        comment result.inspect
        detail "Control: #{control_result.inspect}"

        test do
          assert(result == control_result)
        end
      end
    end
  end
end

require_relative '../automated_init'

context "Run File" do
  context "File Finished" do
    run_file = Run::File.new

    control_file = Controls::File::Create.()

    run_file.(control_file)

    file_finished = run_file.session.one_event(Run::Events::FileFinished)

    test! "Recorded" do
      refute(file_finished.nil?)
    end

    context "Attributes" do
      context "File" do
        file = file_finished.file

        comment file.inspect
        detail "Control: #{control_file.inspect}"

        test do
          assert(file == control_file)
        end
      end

      context "Result" do
        result = file_finished.result

        comment result.inspect

        test "Set" do
          refute(result.nil?)
        end
      end
    end
  end
end

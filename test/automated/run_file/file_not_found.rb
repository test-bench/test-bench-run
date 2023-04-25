require_relative '../automated_init'

context "Run File" do
  context "File Not Found" do
    run_file = Run::File.new

    file = Controls::File.random

    test! "Is an error" do
      assert_raises(Run::File::ReadFileError) do
        run_file.(file)
      end
    end

    context "File Crashed Event" do
      recorded = run_file.session.one_event?(Run::Events::FileCrashed)

      test "Not recorded" do
        refute(recorded)
      end
    end
  end
end

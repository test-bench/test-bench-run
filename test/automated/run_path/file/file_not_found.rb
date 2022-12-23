require_relative '../../automated_init'

context "Run Path" do
  context "File" do
    context "File Not Found" do
      run_path = Run::Path.new

      file = Controls::File::NonExistent.example

      test! "Is an error" do
        assert_raises(Run::Path::ReadFileError) do
          run_path.file(file)
        end
      end

      context "Crashed Event" do
        recorded = run_path.telemetry.one_event?(Run::Events::Crashed)

        test "Not recorded" do
          refute(recorded)
        end
      end
    end
  end
end

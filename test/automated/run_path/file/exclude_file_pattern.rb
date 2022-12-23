require_relative '../../automated_init'

context "Run Path" do
  context "File" do
    context "Exclude File Pattern" do
      control_file = Controls::File::Create.()

      context "File Matches Pattern" do
        run_path = Run::Path.new

        exclude_file_pattern = Controls::File::ExcludePattern::All.example
        run_path.exclude_file_pattern = exclude_file_pattern

        run_path.file(control_file)

        context "Excluded" do
          file_started = run_path.telemetry.one_event?(Run::Events::FileStarted)

          excluded = !file_started

          test do
            assert(excluded)
          end
        end
      end

      context "File Doesn't Match Pattern" do
        run_path = Run::Path.new

        exclude_file_pattern = Controls::File::ExcludePattern::None.example
        run_path.exclude_file_pattern = exclude_file_pattern

        run_path.file(control_file)

        context "Not excluded" do
          file_started = run_path.telemetry.one_event?(Run::Events::FileStarted)

          excluded = !file_started

          test do
            refute(excluded)
          end
        end
      end
    end
  end
end

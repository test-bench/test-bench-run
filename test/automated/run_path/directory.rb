require_relative '../automated_init'

context "Run Path" do
  context "Directory" do
    run_path = Run::Path.new

    count = 2
    control_directory = Controls::Directory::Create.(count)

    run_path.directory(control_directory)

    context "Runs each file in the directory" do
      file_finished_events = run_path.telemetry.events(Run::Events::FileFinished)

      ran_each_file = file_finished_events.count == 2

      test do
        assert(ran_each_file)
      end
    end
  end
end

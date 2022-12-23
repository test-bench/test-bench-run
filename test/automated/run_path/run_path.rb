require_relative '../automated_init'

context "Run Path" do
  context "File" do
    file = Controls::File::Create.()

    run_path = Run::Path.new

    run_path.(file)

    context "Runs the file" do
      ran_file = run_path.telemetry.one_event?(Run::Events::FileFinished)

      test do
        assert(ran_file)
      end
    end
  end

  context "Directory" do
    directory = Controls::Directory::Create.()

    run_path = Run::Path.new

    run_path.(directory)

    context "Runs each file in the directory" do
      file_finished_events = run_path.telemetry.events(Run::Events::FileFinished)

      ran_each_file = file_finished_events.count == 2

      test do
        assert(ran_each_file)
      end
    end
  end
end

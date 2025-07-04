require_relative '../automated_init'

context "Run" do
  context "Path Not Found" do
    run = Run.new

    run.select_files.raise_path_not_found_error!

    run.session.record_file_not_found!

    path = Controls::Path.example

    test! "Isn't an error" do
      refute_raises(SelectFiles::PathNotFoundError) do
        run.path(path)
      end
    end

    context "File Not Found Event" do
      recorded = run.session.file_not_found_event?(file: path)

      test "Recorded" do
        assert(recorded)
      end
    end
  end
end

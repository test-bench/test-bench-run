require_relative '../../automated_init'

context "Run" do
  context "Path" do
    context "File Error" do
      run = Run.new
      run.get_files.file_error!

      path = Controls::Path.example

      comment "Path: #{path.inspect}"

      test "Error is rescued" do
        refute_raises(Run::GetFiles::FileError) do
          run.path(path)
        end
      end

      context "Queried the given path" do
        path_queried = run.get_files.path?(path)

        test do
          assert(path_queried)
        end
      end

      context "Session" do
        session = run.session

        failed = session.failed?

        comment failed.inspect

        test "Failed" do
          assert(failed)
        end
      end

      context "Path Sequence" do
        path_sequence = run.path_sequence

        comment path_sequence.inspect

        test "Incremented" do
          assert(path_sequence == 1)
        end
      end
    end
  end
end

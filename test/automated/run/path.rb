require_relative '../automated_init'

context "Run" do
  context "Path" do
    run = Run.new

    before_path_sequence = 11
    run.path_sequence = before_path_sequence

    file_path = Controls::Path::File.example
    comment "File path: #{file_path.inspect}"

    other_file_path = Controls::Path::File.other_example
    comment "Other file path: #{other_file_path.inspect}"

    run.select_files.set_files([file_path, other_file_path])

    path = Controls::Path.example

    run.path(path)

    context "Path Sequence" do
      path_sequence = run.path_sequence

      comment "Before: #{before_path_sequence.inspect}"
      comment "After: #{path_sequence.inspect}"

      test "Increased" do
        assert(path_sequence > before_path_sequence)
      end
    end

    context "Select Files" do
      path_selected = run.select_files.path?(path)

      test "Path is selected" do
        assert(path_selected)
      end
    end

    context "Session" do
      session = run.session

      test "File is executed" do
        assert(session.executed?(file_path))
      end

      test "Other file is executed" do
        assert(session.executed?(other_file_path))
      end
    end
  end
end

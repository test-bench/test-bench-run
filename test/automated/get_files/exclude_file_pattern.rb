require_relative '../automated_init'

context "Get Files" do
  context "Exclude File Pattern" do
    path = Controls::File::Create.()

    comment "Path: #{path.inspect}"

    context "File Matches" do
      exclude_file_pattern = Controls::File::Pattern::Any.example

      files = []

      Run::GetFiles.(path, exclude_file_pattern:) do |file|
        files << file
      end

      detail "Files:", *files

      test "Doesn't get file" do
        assert(files == [])
      end
    end

    context "File Doesn't Match" do
      exclude_file_pattern = Controls::File::Pattern::None.example

      files = []

      Run::GetFiles.(path, exclude_file_pattern:) do |file|
        files << file
      end

      detail "Files:", *files

      context "Gets file" do
        assert(files == [path])
      end
    end
  end
end

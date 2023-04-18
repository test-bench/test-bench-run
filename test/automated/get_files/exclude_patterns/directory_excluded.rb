require_relative '../../automated_init'

context "Get Files" do
  context "Exclude Patterns" do
    context "Directory is Excluded" do
      path = Controls::Directory::Create.(basename: "some-root-directory")

      directory = Controls::Directory::Create.(parent_directory: path)
      file = Controls::File::Create.(directory:)

      other_file = Controls::File::Create.(directory: path)

      matching_pattern = Controls::Directory::Pattern.example
      non_matching_pattern = Controls::File::Pattern::None.example

      comment "Path: #{path.inspect}"

      context "Directory Matches All Patterns" do
        comment "Pattern: #{matching_pattern.inspect}"

        files = []

        exclude = [matching_pattern]
        Run::GetFiles.(path, exclude:) do |file|
          files << file
        end

        detail "Files: #{files.join(', ')}"

        test "Doesn't get files in the directory" do
          assert(files == [other_file])
        end
      end

      context "Directory Matches One Pattern" do
        exclude = [non_matching_pattern, matching_pattern]

        comment "Patterns: #{exclude.map(&:inspect).join(', ')}"

        files = []

        Run::GetFiles.(path, exclude:) do |file|
          files << file
        end

        detail "Files: #{files.join(', ')}"

        test "Doesn't get files in the directory" do
          assert(files == [other_file])
        end
      end

      context "Directory Doesn't Match Pattern" do
        comment "Pattern: #{non_matching_pattern.inspect}"

        files = []

        exclude = [non_matching_pattern]
        Run::GetFiles.(path, exclude:) do |file|
          files << file
        end

        detail "Files:", *files

        test "Gets files in the directory" do
          assert(files == [file, other_file])
        end
      end
    end
  end
end


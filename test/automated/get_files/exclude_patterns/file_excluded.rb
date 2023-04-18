require_relative '../../automated_init'

context "Get Files" do
  context "Exclude Pattern" do
    context "File is Excluded" do
      path = Controls::File::Create.()

      comment "Path: #{path.inspect}"

      matching_pattern = Controls::File::Pattern.example
      non_matching_pattern = Controls::File::Pattern::None.example

      context "File Matches All Patterns" do
        comment "Pattern: #{matching_pattern.inspect}"

        files = []

        exclude = [matching_pattern]
        Run::GetFiles.(path, exclude:) do |file|
          files << file
        end

        detail "Files: #{files.join(', ')}"

        test "Doesn't get file" do
          assert(files == [])
        end
      end

      context "File Matches One Pattern" do
        exclude = [non_matching_pattern, matching_pattern]

        comment "Patterns: #{exclude.map(&:inspect).join(', ')}"

        files = []

        Run::GetFiles.(path, exclude:) do |file|
          files << file
        end

        detail "Files: #{files.join(', ')}"

        test "Doesn't get file" do
          assert(files == [])
        end
      end

      context "File Doesn't Match" do
        comment "Pattern: #{non_matching_pattern.inspect}"

        files = []

        exclude = [non_matching_pattern]
        Run::GetFiles.(path, exclude:) do |file|
          files << file
        end

        detail "Files: #{files.join(', ')}"

        context "Gets file" do
          assert(files == [path])
        end
      end
    end
  end
end

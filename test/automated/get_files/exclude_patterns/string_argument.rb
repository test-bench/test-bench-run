require_relative '../../automated_init'

context "Get Files" do
  context "Exclude Pattern" do
    context "String Argument" do
      control_pattern = Controls::File::Pattern.example
      other_pattern = Controls::File::Pattern.other_example

      exclude = "#{control_pattern}:#{other_pattern}"

      get_files = Run::GetFiles.build(exclude:)

      context "Exclude Patterns" do
        exclude_patterns = get_files.exclude_patterns

        context "First Pattern" do
          pattern = exclude_patterns[0]

          comment pattern.inspect
          detail "Control: #{control_pattern.inspect}"

          test do
            assert(pattern == control_pattern)
          end
        end

        context "Second Pattern" do
          pattern = exclude_patterns[1]

          comment pattern.inspect
          detail "Control: #{other_pattern.inspect}"

          test do
            assert(pattern == other_pattern)
          end
        end
      end
    end
  end
end

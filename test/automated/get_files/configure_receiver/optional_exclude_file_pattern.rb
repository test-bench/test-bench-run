require_relative '../../automated_init'

context "Get Files" do
  context "Configure Receiver" do
    context "Optional Exclude Patterns Argument" do
      control_pattern = Controls::File::Pattern.example
      control_patterns = [control_pattern]

      receiver = Struct.new(:get_files).new

      Run::GetFiles.configure(receiver, exclude: control_pattern)

      get_files = receiver.get_files

      exclude_patterns = get_files.exclude_patterns

      comment exclude_patterns.inspect
      detail "Control: #{control_patterns.inspect}"

      test do
        assert(exclude_patterns == control_patterns)
      end
    end
  end
end

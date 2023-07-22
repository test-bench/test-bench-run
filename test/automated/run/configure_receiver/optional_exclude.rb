require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    context "Optional Exclude Argument Given" do
      control_pattern = Controls::Random.string
      control_patterns = [control_pattern]

      receiver = Struct.new(:run).new

      Run.configure(receiver, exclude: control_pattern)

      run = receiver.run

      context "Run's Get Files Dependency" do
        get_files = run.get_files

        exclude_patterns = get_files.exclude_patterns

        comment exclude_patterns.inspect
        detail "Control: #{control_patterns.inspect}"

        configured = exclude_patterns == control_patterns

        test "Configured" do
          assert(configured)
        end
      end
    end
  end
end

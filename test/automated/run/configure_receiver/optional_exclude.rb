require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    context "Optional Exclude Given" do
      exclude_file_pattern = 'some-pattern'

      receiver = Struct.new(:run).new

      Run.configure(receiver, exclude: exclude_file_pattern)

      run = receiver.run

      context "Run's Get Files Dependency" do
        get_files = run.get_files

        get_files_exclude_file_pattern = get_files.exclude_file_pattern

        comment get_files_exclude_file_pattern.inspect
        detail "Control: #{exclude_file_pattern.inspect}"

        configured = get_files_exclude_file_pattern == exclude_file_pattern

        test "Configured" do
          assert(configured)
        end
      end
    end
  end
end

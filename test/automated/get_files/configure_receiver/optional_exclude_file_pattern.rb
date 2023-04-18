require_relative '../../automated_init'

context "Get Files" do
  context "Configure Receiver" do
    context "Exclude File Pattern" do
      control_file_pattern = Controls::File::Pattern.example

      receiver = Struct.new(:get_files).new

      Run::GetFiles.configure(receiver, exclude_file_pattern: control_file_pattern)

      get_files = receiver.get_files

      exclude_file_pattern = get_files.exclude_file_pattern

      comment exclude_file_pattern.inspect
      detail "Control: #{control_file_pattern.inspect}"

      test do
        assert(exclude_file_pattern == control_file_pattern)
      end
    end
  end
end

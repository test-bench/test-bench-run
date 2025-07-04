require_relative '../../automated_init'

context "Summary" do
  context "File Stack" do
    context "Push File" do
      file_path = Controls::Path::File.example

      context "Empty Stack" do
        file_stack = Summary::FileStack.new

        file_stack.push(file_path)

        entries = file_stack.entries
        control_entries = [file_path]

        comment entries.inspect
        detail "Control: #{control_entries.inspect}"

        test "Pushed" do
          assert(entries == control_entries)
        end
      end

      context "Non-Empty Stack" do
        file_stack = Summary::FileStack.new

        bottom_file_path = Controls::Path::File.other_example

        file_stack.entries = [bottom_file_path]

        file_stack.push(file_path)

        entries = file_stack.entries
        control_entries = [bottom_file_path, file_path]

        comment entries.inspect
        detail "Control: #{control_entries.inspect}"

        test "Pushed" do
          assert(entries == control_entries)
        end
      end
    end
  end
end

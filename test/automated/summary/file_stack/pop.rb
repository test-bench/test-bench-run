require_relative '../../automated_init'

context "Summary" do
  context "File Stack" do
    context "Pop File Path" do
      context "Empty File Stack" do
        file_stack = Summary::FileStack.new

        file_stack.pop

        entries = file_stack.entries

        comment entries.inspect

        test "Remains empty" do
          assert(entries.empty?)
        end
      end

      context "Non-Empty File Stack" do
        file_stack = Summary::FileStack.new

        control_file_path = Controls::Path::File.example

        file_stack.entries = [
          control_file_path,
          Controls::Path::File.other_example
        ]

        file_stack.pop

        entries = file_stack.entries
        control_entries = [control_file_path]

        comment entries.inspect
        detail "Control: #{control_entries.inspect}"

        test "Popped" do
          assert(entries == control_entries)
        end
      end
    end
  end
end

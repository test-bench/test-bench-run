require_relative '../../automated_init'

context "Summary" do
  context "File Stack" do
    context "Current File" do
      context "Stack Isn't Empty" do
        file_stack = Summary::FileStack.new

        file = Controls::Path::File.example
        other_file = Controls::Path::File.other_example
        file_stack.entries = [other_file, file]

        current_file = file_stack.current_file

        test "Top stack entry" do
          assert(current_file == file)
        end
      end

      context "Negative" do
        context "Stack Is Empty" do
          file_stack = Summary::FileStack.new

          current_file = file_stack.current_file

          test do
            assert(current_file.nil?)
          end
        end
      end
    end
  end
end

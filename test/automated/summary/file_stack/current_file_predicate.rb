require_relative '../../automated_init'

context "Summary" do
  context "File Stack" do
    context "Current File Predicate" do
      context "Affirmative" do
        context "Stack Isn't Empty" do
          file_stack = Summary::FileStack.new

          file_stack.entries << Controls::Path::File.example

          test do
            assert(file_stack.current_file?)
          end
        end
      end

      context "Negative" do
        context "Stack Is Empty" do
          file_stack = Summary::FileStack.new

          test do
            refute(file_stack.current_file?)
          end
        end
      end
    end
  end
end

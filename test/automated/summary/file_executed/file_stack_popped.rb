require_relative '../../automated_init'

context "Summary" do
  context "File Executed" do
    context "File Stack Popped" do
      summary = Summary.new

      control_path = Controls::Path::File.example

      file_stack = summary.file_stack
      file_stack.push(control_path)

      file_executed = Controls::Events::FileExecuted.example
      summary.handle(file_executed)

      popped = file_stack.current_file != control_path

      test do
        assert(popped)
      end
    end
  end
end

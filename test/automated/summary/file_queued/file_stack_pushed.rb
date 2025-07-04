require_relative '../../automated_init'

context "Summary" do
  context "File Queued" do
    context "File Stack Pushed" do
      summary = Summary.new

      control_path = Controls::Path.example
      file_queued = Controls::Events::FileQueued.example(file: control_path)

      summary.handle(file_queued)

      file_stack = summary.file_stack

      pushed = file_stack.current_file == control_path

      detail file_stack.entries.inspect

      test do
        assert(pushed)
      end
    end
  end
end

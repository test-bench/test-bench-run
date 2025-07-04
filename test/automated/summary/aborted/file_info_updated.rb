require_relative '../../automated_init'

context "Summary" do
  context "Aborted" do
    context "File Info Updated" do
      summary = Summary.new

      path = Controls::Path.example
      summary.file_stack.push(path)

      file_info = Controls::Summary::File::Info.example(path:, aborted_events: [])
      summary.add_file(file_info)

      aborted = Controls::Events::Aborted.example
      summary.handle(aborted)

      updated = file_info.aborted_events == [aborted]

      test do
        assert(updated)
      end
    end
  end
end

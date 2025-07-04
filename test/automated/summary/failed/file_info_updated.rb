require_relative '../../automated_init'

context "Summary" do
  context "Failed" do
    context "File Info Updated" do
      summary = Summary.new

      path = Controls::Path.example
      summary.file_stack.push(path)

      file_info = Controls::Summary::File::Info.example(path:, failures: 0)
      summary.add_file(file_info)

      failed = Controls::Events::Failed.example
      summary.handle(failed)

      updated = file_info.failures == "1 failure"

      test do
        assert(updated)
      end
    end
  end
end

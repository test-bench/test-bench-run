require_relative '../../automated_init'

context "Summary" do
  context "Skipped" do
    context "File Info Updated" do
      summary = Summary.new

      path = Controls::Path.example
      summary.file_stack.push(path)

      file_info = Controls::Summary::File::Info.example(path:, skipped: 0)
      summary.add_file(file_info)

      skipped = Controls::Events::Skipped.example
      summary.handle(skipped)

      updated = file_info.skipped == "1+ skipped"

      test do
        assert(updated)
      end
    end
  end
end

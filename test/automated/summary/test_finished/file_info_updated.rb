require_relative '../../automated_init'

context "Summary" do
  context "Test Finished" do
    context "File Info Updated" do
      summary = Summary.new

      path = Controls::Path.example
      summary.file_stack.push(path)

      file_info = Controls::Summary::File::Info.example(path:, tests: 0)
      summary.add_file(file_info)

      test_finished = Controls::Events::TestFinished.example
      summary.handle(test_finished)

      updated = file_info.tests?

      test do
        assert(updated)
      end
    end
  end
end

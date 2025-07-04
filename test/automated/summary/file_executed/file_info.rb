require_relative '../../automated_init'

context "Summary" do
  context "File Executed" do
    context "File Info" do
      context "Passed" do
        file_executed = Controls::Events::FileExecuted::Passed.example

        summary = Summary.new

        path = file_executed.file
        file_info = Controls::Summary::File::Info.example(path:)

        summary.add_file(file_info)

        summary.handle(file_executed)

        context "Removed" do
          removed = summary.files.empty?

          detail summary.files.inspect

          test do
            assert(removed)
          end
        end
      end

      [
        ["Failed", Controls::Events::FileExecuted::Failed.example],
        ["Aborted", Controls::Events::FileExecuted::Aborted.example],
        ["No Result", Controls::Events::FileExecuted::Inert.example],
        ["Incomplete", Controls::Events::FileExecuted::Incomplete.example]
      ].each do |context_title, file_executed|
        summary = Summary.new

        path = file_executed.file
        file_info = Controls::Summary::File::Info.example(path:)

        summary.add_file(file_info)

        summary.handle(file_executed)

        context "Not Removed" do
          removed = summary.files.empty?

          detail summary.files.inspect

          test do
            refute(removed)
          end
        end
      end
    end
  end
end

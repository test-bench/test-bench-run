require_relative '../../automated_init'

context "Error Summary Output" do
  context "Handle File Finished Event" do
    context "Failure" do
      output = Run::Output::Summary::Error.new

      result = Controls::Result.failure
      file = Controls::File.example

      output.start_file(file)

      file_finished = Controls::Events::FileFinished.example(file:, result:)
      output.handle(file_finished)

      context "Failure Summary" do
        failure_summary = output.failure_summary

        context "Entry for file" do
          entry = failure_summary[file]

          comment entry.inspect

          test do
            refute(entry.nil?)
          end
        end
      end
    end
  end
end

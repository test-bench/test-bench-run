require_relative '../../automated_init'

context "Error Summary Output" do
  context "Handle File Finished Event" do
    context "Pass" do
      output = Run::Output::Summary::Error.new

      result = Controls::Result.pass
      file = Controls::File.example

      output.start_file(file)

      file_finished = Controls::Events::FileFinished.example(file:, result:)
      output.handle(file_finished)

      context "Failure Summary" do
        failure_summary = output.failure_summary

        context "No entry for file" do
          entry = failure_summary[file]

          detail entry.class.inspect

          test do
            assert(entry.nil?)
          end
        end
      end
    end
  end
end

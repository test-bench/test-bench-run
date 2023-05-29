require_relative '../../automated_init'

context "Error Summary Output" do
  context "Finish File" do
    context "Pass" do
      result = Controls::Result.pass
      file = Controls::File.example

      output = Run::Output::Summary::Error.new
      output.start_file(file)

      output.finish_file(file, result)

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

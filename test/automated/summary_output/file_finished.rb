require_relative '../automated_init'

context "Summary Output" do
  context "Handle File Finished Event" do
    file_finished = Controls::Events::FileFinished.example

    output = Run::Output::Summary.new

    output.handle(file_finished)

    context "Files Finished" do
      files_finished = output.files_finished

      comment files_finished.inspect

      test "Incremented" do
        assert(files_finished == 1)
      end
    end

    context "Files Crashed" do
      files_crashed = output.files_crashed

      comment files_crashed.inspect

      test "Not incremented" do
        assert(files_crashed == 0)
      end
    end
  end
end

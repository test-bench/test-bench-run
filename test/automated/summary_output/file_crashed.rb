require_relative '../automated_init'

context "Summary Output" do
  context "Handle File Finished Event" do
    file_crashed = Controls::Events::FileCrashed.example

    output = Run::Output::Summary.new

    output.handle(file_crashed)

    context "Files Crashed" do
      files_crashed = output.files_crashed

      comment files_crashed.inspect

      test "Incremented" do
        assert(files_crashed == 1)
      end
    end

    context "Files Finished" do
      files_finished = output.files_finished

      comment files_finished.inspect

      test "Not incremented" do
        assert(files_finished == 0)
      end
    end
  end
end

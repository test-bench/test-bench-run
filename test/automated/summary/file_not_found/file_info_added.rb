require_relative '../../automated_init'

context "Summary" do
  context "File Not Found" do
    context "File Info Added" do
      summary = Summary.new

      control_path = Controls::Path.example
      file_not_found = Controls::Events::FileNotFound.example(file: control_path)

      summary.handle(file_not_found)

      files = summary.files

      test! do
        assert(files.count == 1)
      end

      context "Added File" do
        file = files[control_path]

        context "Attributes" do
          context "Path" do
            path = file.file_path

            comment path.inspect
            detail "Control: #{control_path.inspect}"

            test do
              assert(path == control_path)
            end
          end

          context "Not Found" do
            not_found = file.not_found?

            detail not_found.inspect

            test do
              assert(not_found)
            end
          end
        end
      end
    end
  end
end

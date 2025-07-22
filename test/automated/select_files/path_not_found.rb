require_relative '../automated_init'

context "Select Files" do
  context "Path Not Found" do
    select_files = SelectFiles.new

    path = Controls::Path.example
    comment "Path: #{path.inspect}"

    context "Select Files" do
      selected_files = []

      select_files.(path) do |file_path|
        comment "Selected file: #{file_path.inspect}"

        selected_files << file_path
      end

      context "Given path is selected" do
        selected = selected_files == [path]

        test do
          assert(selected)
        end
      end
    end
  end
end

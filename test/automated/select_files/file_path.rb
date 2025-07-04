require_relative '../automated_init'

context "Select Files" do
  context "File Path" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    detail "Apex directory: #{apex_directory}"

    file_path = Controls::Path::File::Create.(apex_directory:)
    comment "Created file: #{file_path.inspect}"

    select_files = SelectFiles.new

    select_files.apex_directory = apex_directory

    selected_files = []

    path = file_path
    comment "Path: #{path.inspect}"

    context "Select Files" do
      select_files.(path) do |file_path|
        comment "Selected file: #{file_path.inspect}"

        selected_files << file_path
      end

      context "Given file is selected" do
        selected = selected_files == [file_path]

        test do
          assert(selected)
        end
      end
    end

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end

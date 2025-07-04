require_relative '../automated_init'

context "Select Files" do
  context "Directory Path" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    detail "Apex directory: #{apex_directory}"

    directory = Controls::Path.directory

    file_path = Controls::Path::File::Create.(directory:, apex_directory:)
    comment "Created file: #{file_path}"

    other_file_path = Controls::Path::File::Create.(directory: :none, apex_directory:)
    comment "Created other file: #{other_file_path}"

    select_files = SelectFiles.new

    select_files.apex_directory = apex_directory

    selected_files = []

    path = directory
    comment "Path: #{path.inspect}"

    context "Select Files" do
      select_files.(path) do |file_path|
        comment "Selected file: #{file_path}"

        selected_files << file_path
      end

      context "Directory's files are selected" do
        control_files = [file_path]

        selected = selected_files == control_files

        test do
          assert(selected)
        end
      end
    end

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end

require_relative '../automated_init'

context "Select Files" do
  context "Exclude Patterns" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    detail "Apex directory: #{apex_directory}"

    directory = Controls::Path.directory

    file_path = Controls::Path::File::Create.(directory:, apex_directory:)
    comment "Created file: #{file_path.inspect}"

    other_file_path = Controls::Path::File::Create.(directory: :none, apex_directory:)
    comment "Created other file: #{other_file_path.inspect}"

    exclude_pattern = "./#{directory}*"
    comment "Exclude pattern: #{exclude_pattern.inspect}"

    select_files = SelectFiles.new

    select_files.exclude_patterns = [
      "non-matching-pattern-*",
      exclude_pattern
    ]

    select_files.apex_directory = apex_directory

    selected_files = []

    path = '.'
    comment "Path: #{path.inspect}"

    context "Select Files" do
      select_files.(path) do |file_path|
        comment "Selected file: #{file_path.inspect}"

        selected_files << file_path
      end

      context "Matching files aren't selected" do
        control_files = ["./#{other_file_path}"]

        not_selected = selected_files == control_files

        test do
          assert(not_selected)
        end
      end
    end

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end

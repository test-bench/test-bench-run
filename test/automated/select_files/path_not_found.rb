require_relative '../automated_init'

context "Select Files" do
  context "Path Not Found" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    detail "Apex directory: #{apex_directory}"

    select_files = SelectFiles.new

    select_files.apex_directory = apex_directory

    path = Controls::Path.example
    comment "Path: #{path.inspect}"

    context "Select Files" do
      test "Is an error" do
        assert_raises(SelectFiles::PathNotFoundError) do
          select_files.(path) {}
        end
      end
    end

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end

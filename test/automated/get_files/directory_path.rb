require_relative '../automated_init'

context "Get Files" do
  context "Directory Path" do
    context "Directory Exists" do
      path = Controls::Directory::Create.()

      file_1 = Controls::File::Create.(directory: path)

      subdirectory = Controls::Directory::Create.(parent_directory: path)
      file_2 = Controls::File::Create.(directory: subdirectory)

      file_3 = Controls::File::Create.(directory: path)

      comment "Path: #{path.inspect}"

      files = []

      Run::GetFiles.(path) do |file|
        files << file
      end

      context "Gets all files inside the directory" do
        comment "Files:", *files

        control_files = [file_1, file_2, file_3].sort
        detail "Control Files:", *control_files

        test do
          assert(files == control_files)
        end
      end
    end

    context "Directory Doesn't Exist" do
      path = Controls::Directory.random

      comment "Path: #{path.inspect}"

      test "Is an error" do
        assert_raises(Run::GetFiles::FileError) do
          Run::GetFiles.(path) do |file|
            #
          end
        end
      end
    end
  end
end

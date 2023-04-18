require_relative '../automated_init'

context "Get Files" do
  context "File Path" do
    context "File Exists" do
      path = Controls::File::Create.()

      comment "Path: #{path.inspect}"

      files = []

      Run::GetFiles.(path) do |file|
        files << file
      end

      context "Gets file" do
        comment files.inspect

        retrieved = files == [path]

        test do
          assert(retrieved)
        end
      end
    end

    context "File Doesn't Exist" do
      path = Controls::File.random

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

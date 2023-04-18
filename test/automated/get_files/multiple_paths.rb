require_relative '../automated_init'

context "Get Files" do
  context "Multiple Paths" do
    path_1 = Controls::File::Create.()
    path_2 = Controls::File::Create.()

    files = []

    Run::GetFiles.(path_1, path_2) do |file|
      files << file
    end

    comment files.inspect
    detail "Paths: #{path_1}, #{path_2}"

    test do
      assert(files == [path_1, path_2])
    end
  end
end

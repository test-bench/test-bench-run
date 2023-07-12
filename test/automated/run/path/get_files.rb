require_relative '../../automated_init'

context "Run" do
  context "Path" do
    context "Get Files" do
      run = Run.new

      get_files = run.get_files

      path = Controls::Path.example

      file_1 = Controls::File.example
      file_2 = Controls::File.random
      run.get_files.files.concat([file_1, file_2])

      comment "Path: #{path.inspect}"

      run.path(path)

      context "Path is queried" do
        queried_paths = get_files.paths

        comment "Queried Paths:", queried_paths.inspect

        test do
          assert(get_files.path?(path))
        end
      end
    end
  end
end

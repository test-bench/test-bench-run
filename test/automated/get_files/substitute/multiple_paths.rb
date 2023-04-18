require_relative '../../automated_init'

context "Get Files" do
  context "Multiple Paths" do
    substitute = Run::GetFiles::Substitute.build

    path_1 = Controls::Path.random
    path_2 = Controls::Path.random

    substitute.(path_1, path_2) { |_file| }

    context "First Path" do
      path_retrieved = substitute.path?(path_1)

      comment path_retrieved.inspect

      test do
        assert(path_retrieved)
      end
    end

    context "Second Path" do
      path_retrieved = substitute.path?(path_2)

      comment path_retrieved.inspect

      test do
        assert(path_retrieved)
      end
    end
  end
end

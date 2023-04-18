require_relative '../../automated_init'

context "Get Files" do
  context "Substitute" do
    context "File Error" do
      substitute = Run::GetFiles::Substitute.build

      path = Controls::Path.example

      substitute.file_error!

      block_executed = false

      test "Is an error" do
        assert_raises(Run::GetFiles::FileError) do
          substitute.(path) do
            block_executed = true
          end
        end
      end

      test "Block not executed" do
        refute(block_executed)
      end

      context "Path Predicate" do
        path_queried = substitute.path?(path)

        test "Path queried" do
          assert(path_queried)
        end
      end
    end
  end
end

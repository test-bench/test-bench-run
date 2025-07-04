require_relative '../../automated_init'

context "Select Files" do
  context "Substitute" do
    context "Path Not Found Error" do
      substitute = SelectFiles::Substitute.build

      substitute.raise_path_not_found_error!

      test "Is an error" do
        assert_raises(SelectFiles::PathNotFoundError) do
          substitute.(Controls::Path.example) {}
        end
      end
    end
  end
end

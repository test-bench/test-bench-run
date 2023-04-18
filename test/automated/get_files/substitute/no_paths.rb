require_relative '../../automated_init'

context "Get Files" do
  context "No Paths" do
    substitute = Run::GetFiles::Substitute.build

    test "Is an error" do
      assert_raises(ArgumentError) do
        substitute.() { |_file| }
      end
    end
  end
end

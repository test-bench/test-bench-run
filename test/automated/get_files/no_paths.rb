require_relative '../automated_init'

context "Get Files" do
  context "No Paths" do
    test "Is an error" do
      assert_raises(ArgumentError) do
        Run::GetFiles.() { |_file| }
      end
    end
  end
end

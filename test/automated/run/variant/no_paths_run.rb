require_relative '../../automated_init'

context "Run" do
  context "Variant" do
    context "No Paths Run" do
      run = Run.new

      test "Is an error" do
        assert_raises(Run::Error) do
          run.! do
            #
          end
        end
      end
    end
  end
end

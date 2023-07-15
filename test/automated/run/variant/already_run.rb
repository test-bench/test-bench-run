require_relative '../../automated_init'

context "Run" do
  context "Variant" do
    context "Already Run" do
      run = Run.new

      run.path_sequence = 1

      path = Controls::Path.example

      test "Is an error" do
        assert_raises(Run::Error) do
          run.! do
            run.path(path)
          end
        end
      end
    end
  end
end

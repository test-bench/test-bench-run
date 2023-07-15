require_relative '../automated_init'

context "Run" do
  context "Ran Predicate" do
    context "Ran" do
      context "Path Sequence is Greater Than Zero" do
        run = Run.new
        run.path_sequence = 1

        ran = run.ran?

        test do
          assert(ran)
        end
      end
    end

    context "Didn't Run" do
      context "Path Sequence is Zero" do
        run = Run.new
        run.path_sequence = 0

        ran = run.ran?

        test do
          refute(ran)
        end
      end
    end
  end
end

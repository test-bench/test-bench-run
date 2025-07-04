require_relative '../automated_init'

context "Run" do
  context "Ran Predicate" do
    context "Affirmative" do
      context "Path Sequence Is Greater Than Zero" do
        path_sequence = 11

        run = Run.new

        run.path_sequence = path_sequence

        test do
          assert(run.ran?)
        end
      end
    end

    context "Negative" do
      context "Path Sequence Is Zero" do
        path_sequence = 0

        run = Run.new

        run.path_sequence = path_sequence

        test do
          refute(run.ran?)
        end
      end
    end
  end
end

require_relative '../automated_init'

context "Substitute" do
  context "Path Predicate" do
    run = Substitute.build

    path = Controls::Path.example

    run.() do
      run << path
    end

    context "Affirmative" do
      context "Path Was Run" do
        test do
          assert(run.path?(path))
        end
      end
    end

    context "Negative" do
      context "Path Wasn't Run" do
        other_path = Controls::Path.other_example

        test do
          refute(run.path?(other_path))
        end
      end
    end
  end
end

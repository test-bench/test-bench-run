require_relative '../../automated_init'

context "Run" do
  context "Substitute" do
    context "Path Predicate" do
      run = Run::Substitute.build

      path_1 = Controls::Path.example
      path_2 = Controls::Path.random

      run.! do
        run << path_1
        run << path_2
      end

      context "Path Was Run" do
        context "First Path" do
          detail path_1.inspect

          test do
            assert(run.path?(path_1))
          end
        end

        context "Second Path" do
          detail path_2.inspect

          test do
            assert(run.path?(path_2))
          end
        end
      end

      context "Path Wasn't Run" do
        path = Controls::Path.random

        test do
          refute(run.path?(path))
        end
      end
    end
  end
end

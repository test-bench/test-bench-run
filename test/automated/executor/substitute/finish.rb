require_relative '../../automated_init'

context "Executor" do
  context "Substitute" do
    context "Finish" do
      substitute = Run::Executor::Substitute.build

      refute(substitute.finished?)

      substitute.finish

      context "Finished" do
        finished = substitute.finished?

        test do
          assert(finished)
        end
      end
    end
  end
end

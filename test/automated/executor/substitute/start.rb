require_relative '../../automated_init'

context "Executor" do
  context "Substitute" do
    context "Start" do
      substitute = Run::Executor::Substitute.build

      refute(substitute.started?)

      substitute.start

      context "Started" do
        started = substitute.started?

        test do
          assert(started)
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Run" do
  context "Substitute" do
    run = Run::Substitute.build

    refute(run.ran?)

    path = Controls::Path.example
    run.(path)

    test do
      assert(run.ran?)
    end
  end
end

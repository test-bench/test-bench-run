require_relative '../automated_init'

context "Run" do
  context "Session Isolate" do
    run = Run.new

    isolate = run.session.isolate
    refute(isolate.stopped?)

    run.() {}

    test "Stopped" do
      assert(isolate.stopped?)
    end
  end
end

require_relative '../automated_init'

context "Run" do
  context "Session Closed" do
    run = Run.new

    isolate = run.session.isolate
    refute(isolate.stopped?)

    run.() {}

    closed = isolate.stopped?

    test do
      assert(closed)
    end
  end
end

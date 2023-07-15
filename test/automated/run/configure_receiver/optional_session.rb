require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    context "Optional Session Argument Given" do
      control_session = TestBench::Session.new

      receiver = Struct.new(:run).new

      Run.configure(receiver, session: control_session)

      run = receiver.run

      context "Run's Session Dependency" do
        session = run.session

        test "Configured" do
          assert(session == control_session)
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Run File" do
  context "Build" do
    control_session = Session.new

    run_file = Run::File.build(session: control_session)

    context "Session Dependency" do
      session = run_file.session

      context "Configured" do
        configured = session == control_session

        test do
          assert(configured)
        end
      end
    end

    context "Random Generator Dependency" do
      random = run_file.random

      context "Configured" do
        configured = random == TestBench::Random.instance

        test do
          assert(configured)
        end
      end
    end
  end
end

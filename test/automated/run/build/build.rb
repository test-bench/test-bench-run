require_relative '../../automated_init'

context "Run" do
  context "Build" do
    control_pattern = Controls::Random.string
    control_patterns = [control_pattern]

    session = TestBench::Session.new

    run = Run.build(exclude: control_pattern, session:)

    context "Configured" do
      configured = run.session.equal?(session) &&
        run.get_files.instance_of?(Run::GetFiles) &&
        run.executor.instance_of?(Run::Executor::Serial) &&
        run.random == TestBench::Random.instance

      test do
        assert(configured)
      end
    end

    context "Telemetry" do
      telemetry = run.telemetry

      test "Is the session's telemetry" do
        assert(telemetry == session.telemetry)
      end
    end

    context "Get Files" do
      get_files = run.get_files

      context "Exclude Patterns" do
        exclude_patterns = get_files.exclude_patterns

        comment exclude_patterns.inspect
        detail "Control: #{control_patterns.inspect}"

        test do
          assert(exclude_patterns == control_patterns)
        end
      end
    end
  end
end

require_relative '../automated_init'

context "Run" do
  context "Build" do
    control_pattern = Controls::Random.string
    control_patterns = [control_pattern]

    run = Run.build(exclude: control_pattern)

    context "Configured" do
      configured = run.session.instance_of?(Session) &&
        run.telemetry.instance_of?(Telemetry) &&
        run.get_files.instance_of?(Run::GetFiles) &&
        run.executor.instance_of?(Run::Executor::Serial) &&
        run.random == TestBench::Random.instance

      test do
        assert(configured)
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

    context "Session" do
      session = run.session

      context "Telemetry" do
        telemetry = session.telemetry

        test "Is the Run's telemetry" do
          assert(telemetry == run.telemetry)
        end

        context "File Output" do
          registered = telemetry.registered?(Run::Output::File)

          test "Registered" do
            assert(registered)
          end
        end

        context "Error Summary Output" do
          registered = telemetry.registered?(Run::Output::Summary::Error)

          test "Registered" do
            assert(registered)
          end
        end

        context "Summary Output" do
          registered = telemetry.registered?(Run::Output::Summary)

          test "Registered" do
            assert(registered)
          end
        end
      end
    end
  end
end

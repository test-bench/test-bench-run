require_relative '../../automated_init'

context "Run" do
  context "Build" do
    context "Default Session" do
      run = Run.build

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
end

require_relative '../../automated_init'

context "Run Path" do
  context "File" do
    context "Crashed" do
      run_path = Run::Path.new

      control_file = Controls::File::Crash::Create.()
      absolute_path = File.expand_path(control_file)

      begin
        run_path.file(control_file)
      rescue Controls::File::Crash::Error => error
      end

      test "Not rescued" do
        refute(error.nil?)
      end

      context "Crashed Event" do
        crashed = run_path.telemetry.one_event(Run::Events::Crashed)

        context "Attributes" do
          context "File" do
            file = crashed.file

            comment file.inspect
            detail "Absolute Path: #{absolute_path.inspect}"

            test do
              assert(file == absolute_path)
            end
          end

          context "Message" do
            message = crashed.message

            control_message = Controls::File::Crash::Message.example(file: absolute_path)

            comment message.inspect
            detail "Control: #{control_message.inspect}"

            test do
              assert(message == control_message)
            end
          end

          context "Random Seed" do
            random_seed = crashed.random_seed

            comment random_seed.inspect

            test "Set" do
              refute(random_seed.nil?)
            end
          end
        end
      end

      context "File Started Event" do
        recorded = run_path.telemetry.one_event?(Run::Events::FileStarted)

        test "Rcorded" do
          assert(recorded)
        end
      end

      context "File Finished Event" do
        recorded = run_path.telemetry.one_event?(Run::Events::FileFinished)

        test "Not recorded" do
          refute(recorded)
        end
      end
    end
  end
end

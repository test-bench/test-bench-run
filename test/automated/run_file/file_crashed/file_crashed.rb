require_relative '../../automated_init'

context "Run File" do
  context "File Crashed" do
    run_file = Run::File.new

    run_file.root_directory = Controls::File.root_directory

    control_file = Controls::File::Create::Crash.()

    begin
      run_file.(control_file)
    rescue Controls::Exception::Example => exception
    end

    context! "Exception isn't rescued" do
      comment exception.class.inspect

      rescued = exception.nil?

      test do
        refute(rescued)
      end
    end

    context "File Crashed Event" do
      crashed = run_file.session.one_event(Run::Events::FileCrashed)

      context "Attributes" do
        context "File" do
          file = crashed.file

          comment file.inspect
          detail "Control: #{control_file.inspect}"

          test do
            assert(file == control_file)
          end
        end

        context "Error Message" do
          error_message = crashed.error_message

          control_message = Controls::Events::FileCrashed.error_message

          comment error_message.inspect
          detail "Control: #{control_message.inspect}"

          test do
            assert(error_message == control_message)
          end
        end

        context "Error Text" do
          error_text = crashed.error_text

          control_message = Controls::Events::FileCrashed.error_text

          comment error_text.inspect
          detail "Control: #{control_message.inspect}"

          test do
            assert(error_text == control_message)
          end
        end
      end
    end

    context "File Started Event" do
      recorded = run_file.session.telemetry.one_event?(Run::Events::FileStarted)

      test "Recorded" do
        assert(recorded)
      end
    end

    context "File Finished Event" do
      recorded = run_file.session.telemetry.one_event?(Run::Events::FileFinished)

      test "Not recorded" do
        refute(recorded)
      end
    end
  end
end

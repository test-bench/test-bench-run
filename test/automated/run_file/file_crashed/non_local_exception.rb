require_relative '../../automated_init'

context "Run File" do
  context "File Crashed" do
    context "Not Local Exception" do
      run_file = Run::File.new

      run_file.root_directory = '/some-other-root-directory'

      exception_source_file = Controls::Exception::Backtrace::Frame.file
      control_message = Controls::Events::FileCrashed::ErrorMessage.example(file: exception_source_file)

      control_file = Controls::File::Create::Crash.()

      begin
        run_file.(control_file)
      rescue Controls::Exception::Example
      end

      context "File Crashed Error Message" do
        crashed = run_file.session.one_event(Run::Events::FileCrashed)
        error_message = crashed.error_message

        comment error_message.inspect
        detail "Control: #{control_message.inspect}"

        test do
          assert(error_message == control_message)
        end
      end
    end
  end
end

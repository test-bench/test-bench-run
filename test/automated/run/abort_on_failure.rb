require_relative '../automated_init'

context "Run" do
  context "Abort On Failure" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    comment "Apex directory: #{apex_directory.inspect}"

    run = Run.new

    run.abort_on_failure = true

    file_path = Controls::Path::File::Create::Exception.(apex_directory:)
    comment "File path: #{file_path.inspect}"

    other_file_path = Controls::Path::File::Create::Comment.(apex_directory:)
    comment "Other file path: #{other_file_path.inspect}"

    run.select_files.set_files([file_path, other_file_path])

    session = run.session
    Session::Isolate.configure(session, apex_directory:)

    path = Controls::Path.example

    run.path(path)

    context "Failing File" do
      executed = session.file_executed_event?(file: file_path)

      test "Executed" do
        assert(executed)
      end
    end

    context "Subsequent File" do
      executed = session.file_executed_event?(file: other_file_path)

      test "Not executed" do
        refute(executed)
      end
    end

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end

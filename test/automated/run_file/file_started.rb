require_relative '../automated_init'

context "Run File" do
  context "File Started" do
    run_file = Run::File.new

    control_file = Controls::File::Create.()

    run_file.(control_file)

    file_started = run_file.session.one_event(Run::Events::FileStarted)

    test! "Recorded" do
      refute(file_started.nil?)
    end

    context "Attributes" do
      context "File" do
        file = file_started.file

        comment file.inspect
        detail "Control: #{control_file.inspect}"

        test do
          assert(file == control_file)
        end
      end
    end
  end
end

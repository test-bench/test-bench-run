require_relative '../../automated_init'

context "Run Path" do
  context "File" do
    context "File Started" do
      run_path = Run::Path.new

      control_file = Controls::File::Create.()

      run_path.file(control_file)

      file_started = run_path.telemetry.one_event(Run::Events::FileStarted)

      test! "Recorded" do
        refute(file_started.nil?)
      end

      context "Attributes" do
        context "File" do
          file = file_started.file
          absolute_path = File.expand_path(control_file)

          comment file.inspect
          detail "Absolute Path: #{absolute_path.inspect}"

          test do
            assert(file == absolute_path)
          end
        end

        context "Random Seed" do
          random_seed = file_started.random_seed

          comment random_seed.inspect

          test "Set" do
            refute(random_seed.nil?)
          end
        end
      end
    end
  end
end

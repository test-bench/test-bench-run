require_relative '../../automated_init'

context "Run Path" do
  context "File" do
    context "File Finished" do
      run_path = Run::Path.new

      control_file = Controls::File::Create.()

      run_path.file(control_file)

      file_finished = run_path.telemetry.one_event(Run::Events::FileFinished)

      test! "Recorded" do
        refute(file_finished.nil?)
      end

      context "Attributes" do
        context "File" do
          file = file_finished.file
          absolute_path = File.expand_path(control_file)

          comment file.inspect
          detail "Absolute Path: #{absolute_path.inspect}"

          test do
            assert(file == control_file)
          end
        end

        context "Result" do
          result = file_finished.result

          comment result.inspect

          test "Set" do
            refute(result.nil?)
          end
        end

        context "Random Seed" do
          random_seed = file_finished.random_seed

          comment random_seed.inspect

          test "Set" do
            refute(random_seed.nil?)
          end
        end
      end
    end
  end
end

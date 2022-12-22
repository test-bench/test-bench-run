require_relative '../../automated_init'

context "Run Path" do
  context "File" do
    context "Random Seed" do
      run_path = Run::Path.new

      root_seed = 1
      random = TestBench::Random.build(root_seed)
      run_path.random = random

      control_file = Controls::File::Create.()

      control_seed = TestBench::Random.generator_seed(root_seed, control_file)

      context "Run File" do
        run_path.file(control_file)

        context "Seed" do
          seed = random.generator.seed

          comment seed.inspect
          detail "Control: #{control_seed.inspect}"

          namespace_set = seed == control_seed

          test "Namespace set to the file" do
            assert(namespace_set)
          end
        end

        context "File Started Event" do
          file_started = run_path.telemetry.one_event(Run::Events::FileStarted)

          context "Random Seed Attribute" do
            seed = file_started.random_seed

            comment seed.inspect
            detail "Control: #{control_seed.inspect}"

            test do
              assert(seed == control_seed)
            end
          end
        end

        context "File Finished Event" do
          file_finished = run_path.telemetry.one_event(Run::Events::FileFinished)

          context "Random Seed Attribute" do
            seed = file_finished.random_seed

            comment seed.inspect
            detail "Control: #{control_seed.inspect}"

            test do
              assert(seed == control_seed)
            end
          end
        end
      end
    end
  end
end

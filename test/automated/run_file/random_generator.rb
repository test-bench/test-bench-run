require_relative '../automated_init'

context "Run File" do
  context "Random Generator" do
    run_file = Run::File.new

    random = run_file.random
    random.sequence = 1

    file = Controls::File::Create.()
    run_file.(file)

    test "Reset using file as namespace" do
      assert(random.reset?(file))
    end
  end
end

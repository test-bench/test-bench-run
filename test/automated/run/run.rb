require_relative '../automated_init'

context "Run" do
  run = Run.new

  block_argument = nil

  run.() do |arg|
    block_argument = arg
  end

  context "Block is executed" do
    block_executed = !block_argument.nil?

    test do
      assert(block_executed)
    end
  end

  context "Block Argument" do
    test "Is the runner" do
      assert(block_argument == run)
    end
  end
end

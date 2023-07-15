require_relative '../../automated_init'

context "Run" do
  context "Variant" do
    run = Run.new

    path = Controls::Path.example

    block_argument = nil

    run.! do |_block_argument|
      run.path(path)

      block_argument = _block_argument
      block_argument ||= :_
    end

    context "Block is executed" do
      executed = !block_argument.nil?

      test do
        assert(executed)
      end
    end

    context "Block Argument" do
      test "Is the run instance" do
        assert(block_argument == run)
      end
    end
  end
end

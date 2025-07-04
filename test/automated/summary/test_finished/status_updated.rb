require_relative '../../automated_init'

context "Summary" do
  context "Test Finished" do
    context "Status Updated" do
      summary = Summary.new

      skipped = Controls::Events::TestFinished.example
      summary.handle(skipped)

      status = summary.status

      updated = status.result == Session::Result.passed

      test do
        assert(updated)
      end
    end
  end
end

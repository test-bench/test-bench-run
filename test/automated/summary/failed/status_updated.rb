require_relative '../../automated_init'

context "Summary" do
  context "Failed" do
    context "Status Updated" do
      summary = Summary.new

      failed = Controls::Events::Failed.example
      summary.handle(failed)

      status = summary.status

      updated = status.result == Session::Result.failed

      test do
        assert(updated)
      end
    end
  end
end

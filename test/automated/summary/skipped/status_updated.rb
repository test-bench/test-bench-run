require_relative '../../automated_init'

context "Summary" do
  context "Skipped" do
    context "Status Updated" do
      summary = Summary.new

      skipped = Controls::Events::Skipped.example
      summary.handle(skipped)

      status = summary.status

      updated = status.result == Session::Result.incomplete

      test do
        assert(updated)
      end
    end
  end
end

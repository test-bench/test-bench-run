require_relative '../../automated_init'

context "Summary" do
  context "Aborted" do
    context "Status Updated" do
      summary = Summary.new

      aborted = Controls::Events::Aborted.example
      summary.handle(aborted)

      status = summary.status

      updated = status.result == Session::Result.aborted

      test do
        assert(updated)
      end
    end
  end
end

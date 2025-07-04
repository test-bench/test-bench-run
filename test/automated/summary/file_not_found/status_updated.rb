require_relative '../../automated_init'

context "Summary" do
  context "File Not Found" do
    context "Status Updated" do
      summary = Summary.new

      file_not_found = Controls::Events::FileNotFound.example

      summary.handle(file_not_found)

      status = summary.status

      updated = status.result == Session::Result.aborted

      test do
        assert(updated)
      end
    end
  end
end

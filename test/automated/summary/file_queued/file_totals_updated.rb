require_relative '../../automated_init'

context "Summary" do
  context "File Queued" do
    context "File Totals Updated" do
      summary = Summary.new

      file_queued = Controls::Events::FileQueued.example

      summary.handle(file_queued)

      file_totals = summary.file_totals

      context "Attempted" do
        attempted = file_totals.attempted

        control_attempted = "1 file"

        comment attempted.inspect
        detail "Control: #{control_attempted.inspect}"

        updated = attempted == control_attempted

        test "Updated" do
          assert(updated)
        end
      end
    end
  end
end

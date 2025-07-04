require_relative '../../automated_init'

context "Summary" do
  context "File Not Found" do
    context "File Totals Updated" do
      summary = Summary.new

      file_not_found = Controls::Events::FileNotFound.example

      summary.handle(file_not_found)

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

      context "Not Found" do
        not_found = file_totals.not_found

        control_not_found = "1 not found"

        comment not_found.inspect
        detail "Control: #{control_not_found.inspect}"

        updated = not_found == control_not_found

        test "Updated" do
          assert(updated)
        end
      end
    end
  end
end

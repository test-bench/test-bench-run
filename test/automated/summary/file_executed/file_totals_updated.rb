require_relative '../../automated_init'

context "Summary" do
  context "File Executed" do
    context "File Totals Updated" do
      [
        ["Passed", Controls::Events::FileExecuted::Passed.example],
        ["Failed", Controls::Events::FileExecuted::Failed.example],
        ["No Result", Controls::Events::FileExecuted::Inert.example],
        ["Incomplete", Controls::Events::FileExecuted::Incomplete.example]
      ].each do |context_title, file_executed|
        summary = Summary.new

        summary.handle(file_executed)

        file_totals = summary.file_totals

        context "Completed" do
          completed = file_totals.completed

          control_completed = "1 completed"

          comment completed.inspect
          detail "Control: #{control_completed.inspect}"

          updated = completed == control_completed

          test "Updated" do
            assert(updated)
          end
        end

        context "Aborted" do
          aborted = file_totals.aborted

          control_aborted = "0 aborted"

          comment aborted.inspect
          detail "Control: #{control_aborted.inspect}"

          not_changed = aborted == control_aborted

          test "Not changed" do
            assert(not_changed)
          end
        end
      end

      context "Aborted" do
        file_executed = Controls::Events::FileExecuted::Aborted.example

        summary = Summary.new

        summary.handle(file_executed)

        file_totals = summary.file_totals

        context "Aborted" do
          aborted = file_totals.aborted

          control_aborted = "1 aborted"

          comment aborted.inspect
          detail "Control: #{control_aborted.inspect}"

          updated = aborted == control_aborted

          test "Updated" do
            assert(updated)
          end
        end

        context "Completed" do
          completed = file_totals.completed

          control_completed = "0 completed"

          comment completed.inspect
          detail "Control: #{control_completed.inspect}"

          not_changed = completed == control_completed

          test "Not changed" do
            assert(not_changed)
          end
        end
      end
    end
  end
end

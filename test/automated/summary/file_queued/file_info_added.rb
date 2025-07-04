require_relative '../../automated_init'

context "Summary" do
  context "File Queued" do
    context "File Info Added" do
      summary = Summary.new

      control_path = Controls::Path.example
      file_queued = Controls::Events::FileQueued.example(file: control_path)

      summary.handle(file_queued)

      files = summary.files

      test! do
        assert(files.count == 1)
      end

      context "Added File" do
        file = files[control_path]

        context "Attributes" do
          context "Path" do
            path = file.file_path

            comment path.inspect
            detail "Control: #{control_path.inspect}"

            test do
              assert(path == control_path)
            end
          end

          context "Status" do
            status = file.status
            control_status = Session::Status.initial

            comment status.inspect
            detail "Control: #{control_status.inspect}"

            test "Initialized" do
              assert(status == control_status)
            end
          end

          context "Aborted Events" do
            aborted_events = file.aborted_events

            detail aborted_events.inspect

            test "Initialized" do
              assert(aborted_events == [])
            end
          end
        end
      end
    end
  end
end

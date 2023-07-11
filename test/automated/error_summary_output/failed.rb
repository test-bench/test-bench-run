require_relative '../automated_init'

context "Error Summary Output" do
  context "Handle Failed Event" do
    output = Run::Output::Summary::Error.new

    file = Controls::File.random
    output.start_file(file)

    failed = Controls::Events::Session::Failed.example

    control_failure_count = 2
    control_failure_count.times do
      output.handle(failed)
    end

    context "Current File" do
      current_file = output.current_file

      context "Failure Count" do
        failure_count = current_file.failures

        comment failure_count.inspect
        detail "Control: #{control_failure_count.inspect}"

        test do
          assert(failure_count == control_failure_count)
        end
      end
    end
  end
end

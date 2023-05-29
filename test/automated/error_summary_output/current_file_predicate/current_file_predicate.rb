require_relative '../../automated_init'

context "Error Summary Output" do
  context "Current File Predicate" do
    file = Controls::File.example

    context "Corresponds With Current File" do
      output = Run::Output::Summary::Error.new

      output.start_file(file)

      test do
        assert(output.current_file?(file))
      end
    end

    context "Doesn't Correspond With Current File" do
      context "Different File" do
        output = Run::Output::Summary::Error.new

        other_file = Controls::File.random

        output.start_file(other_file)

        test do
          refute(output.current_file?(file))
        end
      end

      context "No Current File" do
        output = Run::Output::Summary::Error.new

        test do
          refute(output.current_file?(file))
        end
      end
    end
  end
end

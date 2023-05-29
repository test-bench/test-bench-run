require_relative '../../automated_init'

context "Error Summary Output" do
  context "Current File Predicate" do
    context "Optional File Argument Omitted" do
      context "Current File" do
        output = Run::Output::Summary::Error.new

        file = Controls::File.example

        current_file = Struct.new(:file).new(file)
        output.current_file = file

        test do
          assert(output.current_file?)
        end
      end

      context "No Current File" do
        output = Run::Output::Summary::Error.new

        test do
          refute(output.current_file?)
        end
      end
    end
  end
end

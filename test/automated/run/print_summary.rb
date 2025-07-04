require_relative '../automated_init'

context "Run" do
  context "Print Summary" do
    context "Enabled" do
      run = Run.new

      run.print_summary = true

      run.() {}

      context "Summary" do
        summary = run.summary

        test "Printed" do
          assert(summary.printed?)
        end
      end
    end

    context "Disabled" do
      run = Run.new

      run.print_summary = false

      run.() {}

      context "Summary" do
        summary = run.summary

        test "Not printed" do
          refute(summary.printed?)
        end
      end
    end
  end
end

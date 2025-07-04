require_relative '../automated_init'

context "Summary" do
  context "Substitute" do
    substitute = Summary::Substitute.build

    refute(substitute.printed?)

    substitute.print

    control_summary = Controls::Summary::Initial.unstyled

    test "Printed" do
      assert(substitute.printed?(control_summary))
    end
  end
end

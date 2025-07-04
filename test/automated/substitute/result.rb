require_relative '../automated_init'

context "Substitute" do
  context "Pass" do
    run = Substitute.build

    control_result = true
    run.set_result(control_result)

    result = run.() {}

    context "Result" do
      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end
  end

  context "Fail" do
    run = Substitute.build

    control_result = false
    run.set_result(control_result)

    result = run.() {}

    context "Result" do
      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end
  end
end

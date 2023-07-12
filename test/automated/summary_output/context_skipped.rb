require_relative '../automated_init'

context "Summary Output" do
  context "Handle Context Skipped Event" do
    context_skipped = Controls::Events::Session::ContextSkipped.example

    output = Run::Output::Summary.new

    output.handle(context_skipped)

    context "Contexts Skipped" do
      contexts_skipped = output.contexts_skipped

      comment contexts_skipped.inspect

      test "Incremented" do
        assert(contexts_skipped == 1)
      end
    end

    context "Tests Skipped" do
      tests_skipped = output.tests_skipped

      comment tests_skipped.inspect

      test "Not incremented" do
        assert(tests_skipped == 0)
      end
    end

    context "Tests Finished" do
      tests_finished = output.tests_finished

      comment tests_finished.inspect

      test "Not incremented" do
        assert(tests_finished == 0)
      end
    end
  end
end

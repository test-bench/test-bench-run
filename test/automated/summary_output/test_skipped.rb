require_relative '../automated_init'

context "Summary Output" do
  context "Handle Test Skipped Event" do
    test_skipped = Controls::Events::Session::TestSkipped.example

    output = Run::Output::Summary.new

    output.handle(test_skipped)

    context "Tests Skipped" do
      tests_skipped = output.tests_skipped

      comment tests_skipped.inspect

      test "Incremented" do
        assert(tests_skipped == 1)
      end
    end

    context "Contexts Skipped" do
      contexts_skipped = output.contexts_skipped

      comment contexts_skipped.inspect

      test "Not incremented" do
        assert(contexts_skipped == 0)
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

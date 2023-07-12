require_relative '../../automated_init'

context "Summary Output" do
  context "Handle Test Finished Event" do
    context "Pass" do
      result = Controls::Result.pass
      test_finished = Controls::Events::Session::TestFinished.example(result:)

      output = Run::Output::Summary.new

      output.handle(test_finished)

      context "Tests Finished" do
        tests_finished = output.tests_finished

        comment tests_finished.inspect

        test "Incremented" do
          assert(tests_finished == 1)
        end
      end

      context "Tests Passed" do
        tests_passed = output.tests_passed

        comment tests_passed.inspect

        test "Incremented" do
          assert(tests_passed == 1)
        end
      end

      context "Tests Failed" do
        tests_failed = output.tests_failed

        comment tests_failed.inspect

        test "Not incremented" do
          assert(tests_failed == 0)
        end
      end
    end
  end
end

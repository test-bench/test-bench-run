require_relative '../../automated_init'

context "Summary Output" do
  context "Finish" do
    context "Styling" do
      context "Pass" do
        output = Run::Output::Summary.new

        output.tests_passed = 111

        writer = output.writer
        writer.styling!

        output.finish

        context "Written Text" do
          writer = output.writer

          written_text = writer.written_text
          control_text = <<~TEXT
          Finished running 0 files, 0 files crashed\e[0m
          Ran 0 tests\e[0m
          \e[1m\e[32m111 passed\e[39m\e[22m, 0 skipped, 0 failed\e[0m
          \e[0m
          TEXT

          comment written_text
          detail "Control:", control_text

          test do
            assert(writer.written?(control_text))
          end
        end
      end

      context "No Tests Passed" do
        output = Run::Output::Summary.new

        output.tests_passed = 0

        writer = output.writer
        writer.styling!

        output.finish

        context "Written Text" do
          writer = output.writer

          written_text = writer.written_text
          control_text = <<~TEXT
          Finished running 0 files, 0 files crashed\e[0m
          Ran 0 tests\e[0m
          \e[1;2;3m0 passed\e[23;22m, 0 skipped, 0 failed\e[0m
          \e[0m
          TEXT

          comment written_text
          detail "Control:", control_text

          test do
            assert(writer.written?(control_text))
          end
        end
      end

      context "Pass With Skipped Tests" do
        output = Run::Output::Summary.new

        output.tests_passed = 111
        output.tests_skipped = 1

        writer = output.writer
        writer.styling!

        output.finish

        context "Written Text" do
          writer = output.writer

          written_text = writer.written_text
          control_text = <<~TEXT
          Finished running 0 files, 0 files crashed\e[0m
          Ran 0 tests\e[0m
          \e[32m111 passed\e[39m, \e[1;33m1 skipped\e[39;22m, 0 failed\e[0m
          \e[0m
          TEXT

          comment written_text
          detail "Control:", control_text

          test do
            assert(writer.written?(control_text))
          end
        end
      end

      context "Failure" do
        output = Run::Output::Summary.new

        output.tests_skipped = 11
        output.tests_failed = 1

        output.files_crashed = 2

        writer = output.writer
        writer.styling!

        output.finish

        context "Written Text" do
          writer = output.writer

          written_text = writer.written_text
          control_text = <<~TEXT
          Finished running 0 files, \e[1;31m2 files crashed\e[0m
          Ran 0 tests\e[0m
          \e[1;2;3m0 passed\e[23;22m, \e[1;33m11 skipped\e[39;22m, \e[1;31m1 failed\e[0m
          \e[0m
          TEXT

          comment written_text
          detail "Control:", control_text

          test do
            assert(writer.written?(control_text))
          end
        end
      end
    end
  end
end

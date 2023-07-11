module TestBench
  class Run
    module Output
      class Summary
        include TestBench::Output
        include Session::Events
        include Events

        def tests_finished
          @tests_finished ||= 0
        end
        attr_writer :tests_finished

        def tests_passed
          @tests_passed ||= 0
        end
        attr_writer :tests_passed

        def tests_failed
          @tests_failed ||= 0
        end
        attr_writer :tests_failed

        handle TestFinished do |test_finished|
          self.tests_finished += 1

          if test_finished.result
            self.tests_passed += 1
          else
            self.tests_failed += 1
          end
        end
      end
    end
  end
end

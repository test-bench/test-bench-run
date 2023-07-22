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

        def tests_skipped
          @tests_skipped ||= 0
        end
        attr_writer :tests_skipped

        def contexts_skipped
          @contexts_skipped ||= 0
        end
        attr_writer :contexts_skipped

        def files_finished
          @files_finished ||= 0
        end
        attr_writer :files_finished

        def files_crashed
          @files_crashed ||= 0
        end
        attr_writer :files_crashed

        attr_accessor :start_time

        handle TestFinished do |test_finished|
          self.tests_finished += 1

          if test_finished.result
            self.tests_passed += 1
          else
            self.tests_failed += 1
          end
        end

        handle TestSkipped do
          self.tests_skipped += 1
        end

        handle ContextSkipped do
          self.contexts_skipped += 1
        end

        handle FileFinished do
          self.files_finished += 1
        end

        handle FileCrashed do
          self.files_crashed += 1
        end

        handle Started do |started|
          start_time = started.metadata.time

          self.start_time = start_time
        end
      end
    end
  end
end

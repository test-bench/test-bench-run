module TestBench
  class Run
    module Output
      class File
        Error = Class.new(RuntimeError)

        include TestBench::Output
        include Events

        def session_output
          @session_output ||= TestBench::Output::Substitute.build
        end
        attr_writer :session_output

        def pended_events
          @pended_events ||= {}
        end
        attr_writer :pended_events

        def only_failure
          @only_failure.nil? ?
            @only_failure = Defaults.only_failure :
            @only_failure
        end
        alias :only_failure? :only_failure
        attr_writer :only_failure

        def configure(...)
          TestBench::Session::Output::Writer.configure(self, ...)

          Session::Output.configure(self, writer:, attr_name: :session_output)
        end

        handle FileStarted do |file_started|
          process_id = file_started.metadata.process_id

          start(process_id)
        end

        def handle_event_data(event_data)
          pend(event_data)
        end

        def pend_event(event_data)
          process_id = event_data.process_id

          if not started?(process_id)
            start(process_id)
          end

          pended_events = self.pended_events[process_id]
          pended_events << event_data
        end
        alias :pend :pend_event

        def pended_event?(event_data)
          process_id = event_data.process_id

          pended_events = self.pended_events.fetch(process_id) do
            return false
          end

          pended_events.include?(event_data)
        end
        alias :pended? :pended_event?

        def start(process_id)
          if started?(process_id)
            raise Error, "Process already started (Process ID: #{process_id})"
          end

          pended_events[process_id] = []
        end

        def started?(process_id)
          pended_events.key?(process_id)
        end

        module Defaults
          def self.only_failure
            ENV.fetch('TEST_BENCH_ONLY_FAILURE', 'off') == 'on'
          end
        end
      end
    end
  end
end

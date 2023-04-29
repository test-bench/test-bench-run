module TestBench
  class Run
    module Output
      class File
        Error = Class.new(RuntimeError)

        include TestBench::Output

        def pended_events
          @pended_events ||= {}
        end
        attr_writer :pended_events

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
      end
    end
  end
end

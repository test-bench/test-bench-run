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

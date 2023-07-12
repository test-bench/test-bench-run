module TestBench
  class Run
    module Executor
      class Serial
        include Executor

        attr_accessor :file_reader
        attr_accessor :file_writer
        attr_accessor :telemetry_reader
        attr_accessor :telemetry_writer

        def session_store
          @session_store ||= Session::Store.new
        end
        attr_writer :session_store

        def configure
          Session::Store.configure(self)
        end

        def start
          self.file_reader, self.file_writer = ::IO.pipe(flags: ::IO::DIRECT | ::IO::SYNC)
          self.telemetry_reader, self.telemetry_writer = ::IO.pipe(flags: ::IO::DIRECT | ::IO::SYNC)

          fork do
            file_writer.close
            telemetry_reader.close

            start!
          end

          file_reader.close
          telemetry_writer.close
        end

        def start!
          telemetry_sink = Telemetry::Sink::File.new(telemetry_writer)

          session = Session.build do |telemetry|
            telemetry.register(telemetry_sink)
          end

          session_store.reset(session)

          run_file = Run::File.build(session:)

          until file_reader.eof?
            file = file_reader.gets(chomp: true)

            run_file.(file)
          end

        rescue => exception

        ensure
          if not exception.nil?
            fork { start! }

            file_reader.close
            telemetry_writer.close

            exit(false)
          end
        end
        # Must refer to line containing "fork { start! }"
        def fork_line = __LINE__ - 9

        def execute(file)
          file_writer.puts(file)

          session = session_store.fetch

          session_projection = Session::Projection.new(session)

          loop do
            event_text = telemetry_reader.gets

            event_data = Telemetry::EventData.load(event_text)
            session.telemetry.record(event_data)

            session_projection.(event_data)

            if event_data.type == :FileCrashed
              dump_exception_text(event_data)
              break
            end

            if event_data.type == :FileFinished
              break
            end
          end
        end

        def finish
          file_writer.close
          telemetry_reader.close

          ::Process.waitall
        end

        def dump_exception_text(file_crashed_data)
          error_text = file_crashed_data.data.last

          error_text.gsub!(backtrace_fork_pattern, '')

          STDERR.write("#{error_text}\n")
        end

        def backtrace_fork_pattern
          @backtrace_fork_pattern ||= /^.*#{__FILE__}:#{fork_line}.*?\n/m
        end
      end
    end
  end
end

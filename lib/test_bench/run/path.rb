module TestBench
  class Run
    class Path
      ReadFileError = Class.new(RuntimeError)

      def exclude_file_pattern
        @exclude_file_pattern ||= Defaults.exclude_file_pattern
      end
      attr_writer :exclude_file_pattern

      def random
        @random ||= Random.new
      end
      attr_writer :random

      def telemetry
        @telemetry ||= Telemetry::Substitute.build
      end
      attr_writer :telemetry

      def session
        @session ||= Session::Substitute.build
      end
      attr_writer :session

      def directory(directory)
        glob_pattern = ::File.join(directory, '**', '*.rb')

        ::Dir.glob(glob_pattern) do |file|
          file(file)
        end
      end

      def file(file)
        if File.fnmatch?(exclude_file_pattern, file)
          return
        end

        absolute_path = ::File.expand_path(file)

        begin
          source = ::File.read(absolute_path)
        rescue SystemCallError => error
          raise ReadFileError, "Couldn't run #{file}: #{error.message.partition(' @ ').first}"
        end

        failure_sequence = session.failure_sequence

        random_seed = random.reset(file)

        telemetry.record(Events::FileStarted.new(absolute_path, random_seed))

        begin
          TOPLEVEL_BINDING.eval(source, absolute_path)

        rescue => error
          error_text = error.full_message(order: :top, highlight: false)
          message = error_text.each_line.first.chomp

          telemetry.record(Events::Crashed.new(absolute_path, message, random_seed))

          raise error
        end

        failed = session.failed?(failure_sequence)
        result = !failed

        telemetry.record(Events::FileFinished.new(file, result, random_seed))
      end

      module Defaults
        def self.exclude_file_pattern
          '_init.rb'
        end
      end
    end
  end
end

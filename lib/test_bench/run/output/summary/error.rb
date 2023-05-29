module TestBench
  class Run
    module Output
      class Summary
        class Error
          StateError = Class.new(RuntimeError)

          include TestBench::Output
          include Events

          attr_accessor :current_file

          def failure_summary
            @failure_summary ||= {}
          end
          attr_writer :failure_summary

          handle FileStarted do |file_started|
            file = file_started.file

            start_file(file)
          end

          def start_file(file)
            if not current_file.nil?
              raise StateError, "Already started file #{current_file.file.inspect} (File: #{file.inspect})"
            end

            file = File.build(file)

            self.current_file = file
          end

          def finish_file(file, result=nil, error_message: nil)
            result ||= false

            if not current_file?(file)
              raise StateError, "Cannot finish file #{file.inspect} (Current File: #{current_file&.file.inspect})"
            end

            if not result
              if not error_message.nil?
                current_file.error_message = error_message
              end

              failure_summary[file] = current_file
            end

            self.current_file = nil
          end

          def current_file?(file=nil)
            return false if current_file.nil?

            if not file.nil?
              file == current_file.file
            else
              true
            end
          end

          File = Struct.new(:file, :failures, :error_message) do
            def self.build(file)
              failures = 0

              new(file, failures)
            end
          end
        end
      end
    end
  end
end

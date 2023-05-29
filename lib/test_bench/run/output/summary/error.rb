module TestBench
  class Run
    module Output
      class Summary
        class Error
          StateError = Class.new(RuntimeError)

          include TestBench::Output
          include Events

          attr_accessor :current_file

          def start_file(file)
            if not current_file.nil?
              raise StateError, "Already started file #{current_file.file.inspect} (File: #{file.inspect})"
            end

            file = File.build(file)

            self.current_file = file
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

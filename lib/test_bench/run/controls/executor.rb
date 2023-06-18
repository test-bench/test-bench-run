module TestBench
  class Run
    module Controls
      module Executor
        def self.example
          Example.new
        end

        class Example
          include TestBench::Run::Executor

          attr_accessor :executed_file

          def execute(file)
            self.executed_file = file
          end

          def executed?(file)
            executed_file == file
          end
        end

        module NotImplemented
          def self.example
            Example.new
          end

          class Example
            include TestBench::Run::Executor
          end
        end
      end
    end
  end
end

module TestBench
  class Run
    module Executor
      AbstractMethodError = Class.new(RuntimeError)

      def start
      end

      def execute(file)
        raise AbstractMethodError, "Subclass didn't implement execute (File: #{file.inspect})"
      end
    end
  end
end

module TestBench
  class Run
    module Executor
      class Serial
        include Executor

        def run_file
          @run_file ||= Run::File.build
        end
        attr_writer :run_file

        def execute(file)
          run_file.(file)
        rescue => exception
          STDERR.write("#{exception.full_message}\n")
        end
      end
    end
  end
end

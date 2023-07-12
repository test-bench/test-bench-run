module TestBench
  class Run
    module Executor
      class Serial
        include Executor

        def run_file
          @run_file ||= Run::File.build
        end
        attr_writer :run_file

        def session
          @session ||= Session::Substitute.build
        end
        attr_writer :session

        def configure
          Session.configure(self)
        end

        def execute(file)
          run_file.(file)
        rescue => exception
          session.record_failure

          STDERR.write("#{exception.full_message}\n")
        end
      end
    end
  end
end

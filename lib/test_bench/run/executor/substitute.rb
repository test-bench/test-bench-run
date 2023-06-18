module TestBench
  class Run
    module Executor
      module Substitute
        def self.build
          Executor.new
        end

        class Executor
          include Run::Executor

          def files
            @files ||= []
          end

          attr_accessor :started
          def started? = !!started

          def start
            self.started = true
          end

          def execute(file)
            files << file
          end

          def executed?(file=nil)
            if not file.nil?
              files.include?(file)
            else
              !files.empty?
            end
          end
        end
      end
    end
  end
end

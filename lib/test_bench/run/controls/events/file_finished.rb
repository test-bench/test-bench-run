module TestBench
  class Run
    module Controls
      module Events
        module FileFinished
          def self.example(path: nil, result: nil, random_seed: nil, process_id: nil, time: nil)
            path ||= self.path
            result = self.result if result.nil?
            random_seed ||= self.random_seed
            process_id ||= self.process_id
            time ||= self.time

            Run::Events::FileFinished.build(path, result, random_seed, process_id:, time:)
          end

          def self.random
            path = File::Path.random
            result = Result.random
            random_seed = Random.integer
            process_id = ProcessID.random
            time = Time.random

            example(path:, result:, random_seed:, process_id:, time:)
          end

          def self.path = File::Path.example
          def self.result = Result.example
          def self.random_seed = FileStarted.random_seed
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end

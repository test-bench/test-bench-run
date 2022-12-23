module TestBench
  class Run
    module Controls
      module Events
        module FileStarted
          def self.example(path: nil, random_seed: nil, process_id: nil, time: nil)
            path ||= self.path
            random_seed ||= self.random_seed
            process_id ||= self.process_id
            time ||= self.time

            Run::Events::FileStarted.build(path, random_seed, process_id:, time:)
          end

          def self.random
            path = File::Path.random
            random_seed = Random.integer
            process_id = ProcessID.random
            time = Time.random

            example(path:, random_seed:, process_id:, time:)
          end

          def self.path = File::Path.example
          def self.random_seed = 1
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end

module TestBench
  class Run
    module Controls
      module Events
        module Crashed
          def self.example(path: nil, message: nil, random_seed: nil, process_id: nil, time: nil)
            path ||= self.path
            message = self.message if message.nil?
            random_seed ||= self.random_seed
            process_id ||= self.process_id
            time ||= self.time

            Run::Events::FileFinished.build(path, message, random_seed, process_id:, time:)
          end

          def self.random
            path = File::Path.random
            message = File::Crash::Message.random
            random_seed = Random.integer
            process_id = ProcessID.random
            time = Time.random

            example(path:, message:, random_seed:, process_id:, time:)
          end

          def self.path = File::Path.example
          def self.message = File::Crash::Message.example
          def self.random_seed = FileStarted.random_seed
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end

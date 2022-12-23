module TestBench
  class Run
    module Events
      FileStarted = Telemetry::Event.define(:file, :random_seed)
      FileFinished = Telemetry::Event.define(:file, :result, :random_seed)
      Crashed = Telemetry::Event.define(:file, :message, :random_seed)
    end
  end
end

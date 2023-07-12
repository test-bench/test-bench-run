module TestBench
  class Run
    Error = Class.new(RuntimeError)

    include Events

    def telemetry
      @telemetry ||= Telemetry::Substitute.build
    end
    attr_writer :telemetry

    def session
      @session ||= Session::Substitute.build
    end
    attr_writer :session

    def get_files
      @get_files ||= GetFiles::Substitute.build
    end
    attr_writer :get_files

    def executor
      @executor ||= Executor::Substitute.build
    end
    attr_writer :executor

    def random
      @random ||= Random::Substitute.build
    end
    attr_writer :random

    def path_sequence
      @path_sequence ||= 0
    end
    attr_writer :path_sequence

    def run(&block)
      if ran?
        raise Error, "Already ran"
      end

      telemetry.record(Started.build(random.seed))

      executor.start

      if not block.nil?
        block.(self)

        if not ran?
          raise Error, "No paths were supplied"
        end
      end

      executor.finish

      if session.passed?
        result = true
      elsif session.failed?
        result = false
      end

      telemetry.record(Finished.build(random.seed, result))
      result
    end
    alias :! :run

    def path(path)
      self.path_sequence += 1

      get_files.(path) do |file|
        executor.execute(file)
      end

    rescue GetFiles::FileError
      warn "#{path}: No such file or directory"

      session.record_failure
    end
    alias :<< :path

    def ran?
      path_sequence > 0
    end
  end
end

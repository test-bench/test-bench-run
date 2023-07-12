module TestBench
  class Run
    include Events

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

    def path_sequence
      @path_sequence ||= 0
    end
    attr_writer :path_sequence

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
  end
end

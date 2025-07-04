require_relative '../automated_init'

context "Run" do
  context "Result" do
    context "Passed" do
      run = Run.new

      result = run.() do
        run.session.status = Controls::Session::Status::Passed.example
      end

      test do
        assert(result)
      end
    end

    context "Failed" do
      run = Run.new

      result = run.() do
        run.session.status = Controls::Session::Status::Failed.example
      end

      test do
        refute(result)
      end
    end
  end
end

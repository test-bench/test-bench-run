require_relative '../../automated_init'

context "Run File" do
  context "Build" do
    context "Optional Session Omitted" do
      run_file = Run::File.build

      context "Session Dependency" do
        session = run_file.session

        context "Configured" do
          configured = session.instance_of?(Session)

          test do
            assert(configured)
          end
        end
      end
    end
  end
end

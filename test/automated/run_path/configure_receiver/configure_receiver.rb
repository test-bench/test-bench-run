require_relative '../../automated_init'

context "Run Path" do
  context "Configure Receiver" do
    attr_name = :run_path
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Run::Path.configure(receiver)

    run_path = receiver.run_path

    context "Configured" do
      configured = run_path.instance_of?(Run::Path) &&
        run_path.session.instance_of?(Session)

      test do
        assert(configured)
      end
    end
  end
end

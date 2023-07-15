require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    attr_name = :run
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Run.configure(receiver)

    run = receiver.public_send(attr_name)

    context "Configured" do
      comment run.class.name

      configured = run.instance_of?(Run) &&
        run.telemetry.instance_of?(TestBench::Telemetry) &&
        run.session.instance_of?(TestBench::Session) &&
        run.get_files.instance_of?(Run::GetFiles) &&
        run.random.instance_of?(TestBench::Random)

      test do
        assert(configured)
      end
    end
  end
end

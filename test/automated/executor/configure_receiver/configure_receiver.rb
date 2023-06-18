require_relative '../../automated_init'

context "Executor" do
  context "Configure Receiver" do
    attr_name = :executor
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Controls::Executor::Example.configure(receiver)

    executor = receiver.public_send(attr_name)

    context "Configured" do
      comment executor.class.name

      configured = executor.instance_of?(Controls::Executor::Example) &&
        executor.configured?

      test do
        assert(configured)
      end
    end
  end
end

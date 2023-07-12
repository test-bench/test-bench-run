require_relative '../../automated_init'

context "Executor" do
  context "Configure Receiver" do
    context "Optional Attribute Name Given" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Controls::Executor::Example.configure(receiver, attr_name:)

      executor = receiver.public_send(attr_name)

      context "Configured" do
        comment executor.class.name

        configured = executor.instance_of?(Controls::Executor::Example)

        test do
          assert(configured)
        end
      end
    end
  end
end

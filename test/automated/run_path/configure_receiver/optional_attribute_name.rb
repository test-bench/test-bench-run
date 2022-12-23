require_relative '../../automated_init'

context "Run Path" do
  context "Configure Receiver" do
    context "Optional Attribute Name" do
      attr_name = :some_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Run::Path.configure(receiver, attr_name:)

      run_path = receiver.public_send(attr_name)

      context "Configured" do
        configured = run_path.instance_of?(Run::Path) &&
          run_path.session.instance_of?(Session)

        test do
          assert(configured)
        end
      end
    end
  end
end

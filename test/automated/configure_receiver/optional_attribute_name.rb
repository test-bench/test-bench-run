require_relative '../automated_init'

context "Configure Receiver" do
  context "Optional Attribute Name Given" do
    attr_name = :some_other_attr
    comment "Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Run.configure(receiver, attr_name:)

    run = receiver.public_send(attr_name)

    context "Configured" do
      comment run.class.name

      configured = run.instance_of?(Run)

      test do
        assert(configured)
      end
    end
  end
end

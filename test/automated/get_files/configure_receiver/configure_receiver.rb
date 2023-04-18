require_relative '../../automated_init'

context "Get Files" do
  context "Configure Receiver" do
    attr_name = :get_files
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Run::GetFiles.configure(receiver)

    get_files = receiver.public_send(attr_name)

    context "Configured" do
      comment get_files.class.name

      configured = get_files.instance_of?(Run::GetFiles)

      test do
        assert(configured)
      end
    end
  end
end

require_relative '../automated_init'

context "File Output" do
  context "Build" do
    file_output = Run::Output::File.build

    test! do
      assert(file_output.instance_of?(Run::Output::File))
    end

    context "Session Output Dependency" do
      session_output = file_output.session_output

      test! "Configured" do
        assert(session_output.instance_of?(Session::Output))
      end

      context "Session Output's Writer" do
        session_output_writer = session_output.writer

        test "Is the file output's writer" do
          assert(session_output_writer == file_output.writer)
        end

        test "Is a session writer" do
          assert(session_output_writer.instance_of?(Session::Output::Writer))
        end
      end
    end
  end
end

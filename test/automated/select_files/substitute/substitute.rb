require_relative '../../automated_init'

context "Select Files" do
  context "Substitute" do
    substitute = SelectFiles::Substitute.build

    control_files = [
      Controls::Path::File.example,
      Controls::Path::File.other_example
    ]
    substitute.set_files(control_files)

    selected_files = []

    substitute.(Controls::Path.example) do |file_path|
      selected_files << file_path
    end

    context "Selected Files" do
      comment selected_files.inspect
      detail "Control: #{control_files.inspect}"

      test do
        assert(selected_files == control_files)
      end
    end
  end
end

require_relative '../../automated_init'

context "Get Files" do
  context "Substitute" do
    substitute = Run::GetFiles::Substitute.build

    control_files = [
      'some_file.rb',
      'some_other_file.rb'
    ]
    substitute.set_files(control_files)

    files = []

    substitute.('some_path') do |file|
      files << file
    end

    context "Files" do
      comment files.inspect
      detail "Control: #{control_files.inspect}"

      test do
        assert(files == control_files)
      end
    end
  end
end

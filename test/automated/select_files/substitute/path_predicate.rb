require_relative '../../automated_init'

context "Select Files" do
  context "Substitute" do
    context "Path Predicate" do
      path = Controls::Path.example

      substitute = SelectFiles::Substitute.build

      substitute.(path) {}

      context "Affirmative" do
        path_retrieved = substitute.path?(path)

        comment path_retrieved.inspect

        test do
          assert(path_retrieved)
        end
      end

      context "Negative" do
        other_path = Controls::Path.other_example

        path_retrieved = substitute.path?(other_path)

        comment path_retrieved.inspect

        test do
          refute(path_retrieved)
        end
      end
    end
  end
end

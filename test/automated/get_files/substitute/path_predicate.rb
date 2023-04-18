require_relative '../../automated_init'

context "Get Files" do
  context "Substitute" do
    context "Path Predicate" do
      path = Controls::Path.example

      substitute = Run::GetFiles::Substitute.build

      substitute.(Controls::Path.random)
      substitute.(path)

      context "Path Retrieved" do
        path_retrieved = substitute.path?(path)

        comment path_retrieved.inspect

        test do
          assert(path_retrieved)
        end
      end

      context "Path Not Retrieved" do
        other_path = Controls::Path.random

        path_retrieved = substitute.path?(other_path)

        comment path_retrieved.inspect

        test do
          refute(path_retrieved)
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Run" do
  context "Path" do
    run = Run.new

    path = Controls::Path.example

    original_path_sequence = 11
    run.path_sequence = original_path_sequence

    file_1 = Controls::File.example
    file_2 = Controls::File.random
    run.get_files.files.concat([file_1, file_2])

    comment "Path: #{path.inspect}"

    run.path(path)

    context "Path Sequence" do
      path_sequence = run.path_sequence

      comment path_sequence.inspect
      detail "Original Path Sequence: #{original_path_sequence.inspect}"

      test "Incremented" do
        assert(path_sequence == original_path_sequence + 1)
      end
    end

    context "File Executor" do
      file_executor = run.executor

      context "First File" do
        executed = file_executor.executed?(file_1)

        detail "File: #{file_1.inspect}"

        test "Executed" do
          assert(executed)
        end
      end

      context "Second File" do
        executed = file_executor.executed?(file_2)

        detail "File: #{file_2.inspect}"

        test "Executed" do
          assert(executed)
        end
      end
    end
  end
end

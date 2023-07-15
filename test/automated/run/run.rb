require_relative '../automated_init'

context "Run" do
  run = Run.new

  path = Controls::Path.example
  run.(path)

  context "Path Sequence" do
    path_sequence = run.path_sequence

    comment path_sequence.inspect

    test "Incremented" do
      assert(path_sequence == 1)
    end
  end

  context "Started" do
    started_recorded = run.telemetry.one_event?(Run::Events::Started)

    test "Recorded" do
      assert(started_recorded)
    end
  end

  context "Finished" do
    finished_recorded = run.telemetry.one_event?(Run::Events::Finished)

    test "Recorded" do
      assert(finished_recorded)
    end
  end
end

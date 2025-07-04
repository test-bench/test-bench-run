require_relative '../automated_init'

context "Substitute" do
  run = Substitute.build

  refute(run.ran?)

  run.() do
    run << Controls::Path.example
  end

  test "Ran" do
    assert(run.ran?)
  end
end

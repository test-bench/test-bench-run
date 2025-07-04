require_relative '../automated_init'

context "Exclude File Pattern Default" do
  original_env = ENV.to_h

  env_var = 'TEST_BENCH_EXCLUDE_FILE_PATTERN'

  context "#{env_var} Isn't Set" do
    ENV.clear

    select_files = SelectFiles.build

    exclude_patterns = select_files.exclude_patterns

    control_patterns = ['*_init.rb']

    comment exclude_patterns.inspect
    detail "Control: #{control_patterns.inspect}"

    test do
      assert(exclude_patterns == control_patterns)
    end
  end

  context "#{env_var} Is Set" do
    ENV[env_var] = 'some*pattern:some*other*pattern'

    select_files = SelectFiles.build

    exclude_patterns = select_files.exclude_patterns

    control_patterns = ['some*pattern', 'some*other*pattern']

    comment exclude_patterns.inspect
    detail "Control: #{control_patterns.inspect}"

    test do
      assert(exclude_patterns == control_patterns)
    end
  end

ensure
  ENV.replace(original_env)
end

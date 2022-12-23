module TestBench
  class Run
    module Controls
      module File
        module Create
          def self.call(contents=nil)
            contents ||= self.contents

            file = TestBench::Telemetry::Controls::File::Temporary.random(extension:)

            ::File.write(file, contents)

            file
          end

          def self.contents = Pass::Create.contents
          def self.extension = '.rb'
        end

        module Pass
          module Create
            def self.call
              File::Create.(contents)
            end

            def self.contents
              ''
            end
          end
        end

        module Failure
          module Create
            def self.call(session: nil)
              contents = contents(session:)

              File::Create.(contents)
            end

            def self.contents(session: nil)
              session ||= Session.new

              <<~RUBY
              session = ObjectSpace._id2ref(#{session.object_id})
              session.test do
                session.assert(false)
              end
              RUBY
            end
          end
        end

        module Crash
          module Create
            def self.call
              File::Create.(contents)
            end

            def self.contents
              "raise #{Exception}.example"
            end
          end

          module Message
            def self.example(file: nil, exception_message: nil, exception_class: nil)
              file ||= Path.example
              exception_class ||= Exception::Example
              exception_message ||= Exception::Message.example

              "#{file}:1:in `<main>': #{exception_message} (#{exception_class})"
            end

            def self.random
              file = Path.random
              exception_message = Exception::Message.random

              example(file:, exception_message:)
            end
          end

          Exception = Fixture::Controls::Exception

          Error = Exception::Example
        end

        module NonExistent
          def self.example = Path.random
        end

        module Path
          def self.example(suffix=nil)
            extension = File::Create.extension

            file = TestBench::Telemetry::Controls::File::Temporary.example(suffix, extension:)

            ::File.expand_path(file)
          end

          def self.random = example(Random.string)
        end

        module ExcludePattern
          module All
            def self.example = '*'
          end

          module None
            def self.example = Random.string
          end
        end
      end
    end
  end
end

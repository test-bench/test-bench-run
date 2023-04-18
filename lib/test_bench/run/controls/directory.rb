module TestBench
  class Run
    module Controls
      module Directory
        def self.example(name=nil, parent_directory: nil, root_directory: nil)
          name ||= self.name
          parent_directory ||= self.parent_directory

          ::File.join(parent_directory, name)
        end

        def self.random(parent_directory: nil)
          name = Name.random

          example(name, parent_directory:)
        end

        def self.name
          Name.example
        end

        def self.parent_directory
          File::Create.directory
        end

        def self.root_directory
          File::Create.root_directory
        end

        module Name
          def self.example
            "some-directory"
          end

          def self.random
            suffix = Random.string

            "#{example}-#{suffix}"
          end
        end

        module Create
          def self.call(parent_directory: nil)
            directory = Directory.random(parent_directory:)

            ::Dir.mkdir(directory)

            directory
          end
        end
      end
    end
  end
end

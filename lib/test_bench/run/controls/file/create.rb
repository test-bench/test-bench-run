module TestBench
  class Run
    module Controls
      module File
        module Create
          def self.call(contents: nil, directory: nil)
            contents ||= self.contents
            directory ||= self.directory

            filename = File::Name::Random.example

            file = ::File.join(directory, filename)

            ::File.write(file, contents)

            file
          end

          def self.contents
            '# Some file'
          end

          def self.directory
            'tmp'
          end
        end
      end
    end
  end
end

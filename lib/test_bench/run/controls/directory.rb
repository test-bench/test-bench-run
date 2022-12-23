module TestBench
  class Run
    module Controls
      module Directory
        module Create
          def self.call(count=nil, file_contents: nil, name: nil)
            count ||= 2
            file_contents ||= File::Create.contents
            name ||= "some-dir-#{Random.string}"

            directory = ::File.join('tmp', name)

            ::Dir.mkdir(directory)

            count.times do |index|
              file = ::File.join(directory, "#{index + 1}.rb")

              ::File.write(file, file_contents)
            end

            directory
          end
        end
      end
    end
  end
end

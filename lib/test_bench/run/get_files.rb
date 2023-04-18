module TestBench
  class Run
    class GetFiles
      FileError = Class.new(RuntimeError)

      def exclude_file_pattern
        @exclude_file_pattern ||= Defaults.exclude_file_pattern
      end
      attr_writer :exclude_file_pattern

      def self.build(exclude_file_pattern: nil)
        instance = new

        if not exclude_file_pattern.nil?
          instance.exclude_file_pattern = exclude_file_pattern
        end

        instance
      end

      def self.call(path, *paths, exclude_file_pattern: nil, &block)
        instance = build(exclude_file_pattern:)
        instance.(path, *paths, &block)
      end

      def self.configure(receiver, exclude_file_pattern: nil, attr_name: nil)
        attr_name ||= :get_files

        instance = build(exclude_file_pattern:)
        receiver.public_send(:"#{attr_name}=", instance)
      end

      def call(path, *paths, &block)
        paths = [path, *paths]

        exclude_file_pattern = ::File.join('*/', self.exclude_file_pattern)

        paths.each do |path|
          if ::File.extname(path).empty?
            pattern = ::File.join(path, '**/*.rb')
          else
            pattern = path
          end

          assure_extant(path)

          Dir.glob(pattern).each do |file|
            if ::File.fnmatch?(exclude_file_pattern, file, ::File::FNM_EXTGLOB)
              next
            end

            block.(file)
          end
        end
      end

      def assure_extant(path)
        ::File.stat(path)
      rescue Errno::ENOENT => enoent
        raise FileError, enoent.message
      end

      module Defaults
        def self.exclude_file_pattern
          ENV.fetch('TEST_BENCH_EXCLUDE_FILE_PATTERN', '*_init.rb')
        end
      end
    end
  end
end

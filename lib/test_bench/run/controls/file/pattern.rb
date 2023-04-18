module TestBench
  class Run
    module Controls
      module File
        module Pattern
          def self.example
            Any.example
          end

          module Any
            def self.example
              '*'
            end
          end

          module None
            def self.example
              random
            end

            def self.random
              Controls::Random.string
            end
          end
        end
      end
    end
  end
end

require_relative 'utils'
require 'fileutils'

module NewDay
  class << self
    include AdventOfCode::Utils

    def create_files(day, year)
      create_directories(year)

      write_test_file(day, year)
      write_ruby_file(day, year)
      touch_input_file(day, year)
    end

    def create_directories(year)
      idempotent_create(File.join(expanded_directory, year.to_s, "test"))
      idempotent_create(File.join(expanded_directory, year.to_s, "code"))
      idempotent_create(File.join(expanded_directory, year.to_s, "input"))
    end

    def idempotent_create(dirname)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
    end

    def write_ruby_file(day, year)
      ruby_file_text = <<~RUBY_TEMPLATE
      require_relative '../../day.rb'

      module AdventOfCode
        module Year#{year}
          class #{day_class_string(day, year)} < AdventOfCode::Day
            DAY = #{day}
            YEAR = #{year}
            INPUT_PARSER = lambda { |line| line }

            class << self
              def run_a
                # put your code here
              end

              def run_b
                # put your code here
              end
            end
          end
        end
      end
      RUBY_TEMPLATE

      File.write(ruby_filename(day, year), ruby_file_text)
    end

    def write_test_file(day, year)
      day_string = leading_zero(day)

      test_file_text = <<~TEST_TEMPLATE
        require_relative "../code/day_#{day_string}.rb"
        require_relative "../../base_test.rb"

        class Test#{year}#{day} < BaseTest
          def day_number
            #{day}
          end

          def year_number
            #{year}
          end

          def test_run_a
            input_blob(
              <<~INPUT
                
              INPUT
            )
            assert_equal(0, run_a)
          end

          def test_run_b
            input_blob(
              <<~INPUT
                
              INPUT
            )
            assert_equal(0, run_b)
          end
        end
      TEST_TEMPLATE

      File.write(test_filename(day, year), test_file_text)
    end

    def touch_input_file(day, year)
      File.write(input_filename(day, year), "")
    end
  end
end

year, day = ARGV.map(&:to_i)
NewDay.create_files(day, year)

require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day20 < AdventOfCode::Day
      DAY = 20
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line }

      class ImageEnhancer
        def initialize(enhancer, image)
          @enhancer = enhancer
          @image = image.split("\n").map { |row| row.split("") }
        end

        def enhance
          new_image = []
          next_size.times do |i|
            new_image << [].tap { |a| next_size.times { |j| a << enhanced_pixel(i - 1, j - 1) } }
          end
          @image = new_image
          reset_new_pixel
        end

        def reset_new_pixel
          if @new_pixel == "."
            @new_pixel = @enhancer[0]
          else
            @new_pixel = @enhancer[-1]
          end
        end

        def enhanced_pixel(i, j)
          binary_a = []
          [-1, 0, 1].each do |x|
            [-1, 0, 1].each do |y|
              binary_a << get_binary_at(i + x, j + y)
            end
          end
          @enhancer[binary_a.join.to_i(2)]
        end

        def size
          @image.size
        end

        def next_size
          @image.size + 2
        end

        def new_pixel
          @new_pixel ||= "."
        end

        def get_binary_at(i, j)
          int = new_pixel if i < 0 || j < 0 || j >= size || i >= size
          int ||= @image[i][j]
          int == "." ? 0 : 1
        end

        def print
          puts @image.map(&:join).join("\n")
        end

        def lit_up
          @image.flatten.count { |x| x == "#" }
        end
      end

      class << self
        def enhance_image(enhancer, image, cycles)
          image_enhancer = ImageEnhancer.new(enhancer, image)
          cycles.times { image_enhancer.enhance }
          image_enhancer.lit_up
        end

        def run_a
          enhance_image(*input_blob.split("\n\n"), 2)
        end

        def run_b
          enhance_image(*input_blob.split("\n\n"), 50)
        end
      end
    end
  end
end

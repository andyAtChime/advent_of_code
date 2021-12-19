require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day18 < AdventOfCode::Day
      DAY = 18
      YEAR = 2021
      INPUT_PARSER = lambda { |line| line }

      class Tree
        def self.step_through(input_lines)
          Tree.new(input_lines).tap { |t| t.step_through }
        end

        def initialize(input_lines)
          @numbers = input_lines.map { |l| eval(l) }
          @root = Pair.new(@numbers.shift)
        end

        def step_through
          step while @numbers.size > 0
        end

        def step
          @root = @root.add(@numbers.shift)
          loop do
            next if explode_next
            break unless split_first
          end
        end

        def explode_next
          depths = ordered_depths
          i = 0
          until i >= depths.size do
            if depths[i][1] > 4
              left = depths[i - 1][0] if i > 0
              right = depths[i + 2][0] if i + 2 < depths.size
              new_node = explode(depths[i][0].parent, left, right)
              return true
            end
            i += 1
          end
        end

        def explode(pair, left, right)
          left.value += pair.left.value if left
          right.value += pair.right.value if right
          pair.replace_with(Primitive.new(0, pair.parent))
        end

        def ordered_depths
          @root.children_with_depth(0)
        end

        def split_first
          depths = ordered_depths.each do |node, _|
            next if node.value < 10
            split = [node.value / 2, node.value - node.value / 2]
            node.replace_with(Pair.new(split, node.parent))
            return true
          end
          return false
        end

        def to_a
          @root.to_a
        end

        def magnitude
          @root.magnitude
        end
      end

      class Node
        attr_accessor :parent

        def left_child?
          if @parent
            @parent.left == self
          end
        end

        def to_s
          to_a.to_s
        end

        def right_child?
          if @parent
            @parent.right == self
          end
        end

        def replace_with(node)
          if left_child?
            parent.left = node
          else
            parent.right = node
          end
        end
      end

      class Pair < Node
        attr_accessor :left, :right

        def initialize(array, parent=nil)
          a, b = array
          @parent = parent
          @left = new_node(a)
          @right = new_node(b)
        end

        def add(pair)
          @parent = Pair.new([self, pair])
        end

        def new_node(x)
          return x if x.is_a?(Pair)
          (x.is_a?(Integer) ? Primitive : Pair).new(x, self)
        end

        def children_with_depth(depth)
          @left.children_with_depth(depth + 1) +
            @right.children_with_depth(depth + 1)
        end

        def to_a
          [@left.to_a, @right.to_a]
        end

        def magnitude
          left.magnitude * 3 + right.magnitude * 2
        end
      end

      class Primitive < Node
        attr_accessor :value

        def initialize(value, parent)
          @parent = parent
          @value = value
        end

        def magnitude
          @value
        end

        def to_a
          @value
        end

        def children_with_depth(depth)
          [[self, depth]]
        end
      end

      class << self
        def run_a
          Tree.step_through(input_lines).magnitude
        end

        def run_b
          input_lines.permutation(2).map { |p| Tree.step_through(p).magnitude }.max
        end
      end
    end
  end
end

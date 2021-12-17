require_relative '../../day.rb'

module AdventOfCode
  module Year2021
    class AdventOfCode::Year2021::Day16 < AdventOfCode::Day
      DAY = 16
      YEAR = 2021
      INPUT_PARSER = lambda do |line|
        line.scan(/.{2}/).map do |chonk|
          a = chonk.to_i(16).to_s(2)
          "0" * (8 - a.size) + a
        end.join
      end

      class Packet
        attr_reader :length, :value

        def initialize(s)
          @raw_input = s
          @sub_packets = []
          parse_packet
        end

        def add_subpacket_at(i)
          @sub_packets << Packet.new(@raw_input[i..])
        end

        def parse_subpackets
          case length_type
          when :bit_length
            subpacket_length = @raw_input[7...22].to_i(2)
            parse_sub_by_length(subpacket_length)
          when :sub_packets
            subpacket_count = @raw_input[7...18].to_i(2)
            parse_sub_by_packets(subpacket_count)
          end
        end

        def parse_packet
          @value = case type_id
          when 0
            parse_subpackets
            sub_values.sum
          when 1
            parse_subpackets
            sub_values.reduce(:*)
          when 2
            parse_subpackets
            sub_values.min
          when 3
            parse_subpackets
            sub_values.max
          when 4
            parse_literal
          when 5
            parse_subpackets
            sub_values[0..1].inject(">") ? 1 : 0
          when 6
            parse_subpackets
            sub_values[0..1].inject("<") ? 1 : 0
          when 7
            parse_subpackets
            sub_values[0..1].inject("==") ? 1 : 0
          end
          p @value
        end

        def parse_literal
          i = 0
          assembled_value = ""
          loop do
            offset = i * 5
            assembled_value += @raw_input[(7 + offset)...(11 + offset)]
            i += 1
            break if @raw_input[6 + offset] == "0"
          end
          @length = i * 5 + 6
          @value = assembled_value.to_i(2)
        end

        def parse_sub_by_length(n)
          loop do
            add_subpacket_at(22 + subpacket_length)
            break if subpacket_length == n
          end
          @length = n + 22
        end

        def parse_sub_by_packets(n)
          n.times { add_subpacket_at(18 + subpacket_length) }
          @length = subpacket_length + 18
        end

        def version_sum
          @raw_input[0...3].to_i(2) + @sub_packets.map(&:version_sum).sum
        end

        def type_id
          @type_id ||= @raw_input[3...6].to_i(2)
        end

        def length_type
          @length_type ||= @raw_input[6] == "0" ? :bit_length : :sub_packets
        end

        def subpacket_length
          @sub_packets.map(&:length).sum
        end

        def sub_values
          @sub_packets.map(&:value)
        end
      end

      class << self
        def run_a
          Packet.new(parsed_input[0]).version_sum
        end

        def run_b
          Packet.new(parsed_input[0]).value
        end
      end
    end
  end
end

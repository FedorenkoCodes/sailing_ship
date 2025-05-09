require 'json'

require_relative 'modes/cheapest_calculator'
require_relative 'modes/cheapest_direct_calculator'
require_relative 'modes/fastest_calculator'

class ShippingCalculator
  VALID_CRITERIA = %w[cheapest-direct cheapest fastest].freeze
  MAX_INPUT_LENGTH = 100

  def initialize
    @origin_port = nil
    @destination_port = nil
    @criteria = nil
  end

  def calculate
    get_user_input

    if input_valid?
      output_data = calculate_shipping_costs

      output_json = JSON.pretty_generate(output_data)
      puts output_json
    else
      puts "Invalid input"
    end
  end

  private

  def calculate_shipping_costs
    case @criteria
    when 'cheapest'
      CheapestCalculator.calculate(@origin_port, @destination_port)
    when 'cheapest-direct'
      CheapestDirectCalculator.calculate(@origin_port, @destination_port)
    when 'fastest'
      FastestCalculator.calculate(@origin_port, @destination_port)
    else
      raise "Invalid criteria: #{@criteria}"
    end
  end

  def get_user_input
    while (line = gets)
      line = line.chomp

      if @origin_port.nil?
        @origin_port = line.strip
      elsif @destination_port.nil?
        @destination_port = line.strip
      elsif @criteria.nil?
        @criteria = line.strip
      end

      break if @origin_port && @destination_port && @criteria
    end
  end

  def input_valid?
    return false unless input_length_valid?
    return false unless valid_criteria?

    true
  end

  def valid_criteria?
    VALID_CRITERIA.include?(@criteria)
  end

  def input_length_valid?
    @origin_port.length <= MAX_INPUT_LENGTH && @destination_port.length <= MAX_INPUT_LENGTH
  end
end

ShippingCalculator.new.calculate

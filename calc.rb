require 'json'
require 'dotenv'

require_relative 'modes/cheapest_calculator'
require_relative 'modes/cheapest_direct_calculator'
require_relative 'modes/fastest_calculator'

Dotenv.load

class ShippingCalculator
  VALID_CRITERIA = %w[cheapest-direct cheapest fastest].freeze

  def initialize
    @origin_port = nil
    @destination_port = nil
    @criteria = nil
  end

  def fake_input
    @origin_port = 'CNSHA'
    @destination_port = 'NLRTM'
    @criteria = 'cheapest-direct'
  end

  def toot
    ENV['FAKE_INPUT'] ? fake_input : get_user_input

    if input_valid?
      sailings = calculate_shipping_costs

      print_sailings(sailings)
    else
      puts "Invalid input"
    end
  end

  private

  def print_sailings(sailings)
    results = []

    sailings.each do |sailing|
      results <<
        {
          origin_port: sailing['origin_port'],
          destination_port: sailing['destination_port'],
          departure_date: sailing['departure_date'],
          arrival_date: sailing['arrival_date'],
          sailing_code: sailing['sailing_code'],
          rate: sailing['rate'],
          rate_currency: sailing['rate_currency']
        }

    end

    puts JSON.pretty_generate(results)
  end

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
    @origin_port.length <= ENV['MAX_INPUT_LENGTH'].to_i && @destination_port.length <= ENV['MAX_INPUT_LENGTH'].to_i
  end
end

ShippingCalculator.new.toot

require 'json'

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
      output_data = [
        {
          origin_port: @origin_port,
          destination_port: @destination_port,
          criteria: @criteria,
        }
      ]
      output_json = JSON.pretty_generate(output_data)
      puts output_json
    else
      puts "Invalid input"
    end
  end

  private

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
    end
  end

  def input_valid?
    return false unless @origin_port && @destination_port && @criteria
    return false unless input_length_valid?
    return false unless valid_criteria?

    true
  end

  def valid_criteria?
    VALID_CRITERIA.include?(@criteria)
  end

  def input_length_valid?
    @origin_port.length <= MAX_INPUT_LENGTH ||
      @destination_port.length <= MAX_INPUT_LENGTH ||
      @criteria.length <= MAX_INPUT_LENGTH
  end
end

ShippingCalculator.new.calculate

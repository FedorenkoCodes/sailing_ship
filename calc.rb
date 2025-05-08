require 'json'

class ShippingCalculator
  def initialize
    @origin_port = nil
    @destination_port = nil
    @criteria = nil
  end

  def calculate
    get_user_input

    if input_valid?(@origin_port, @destination_port, @criteria)
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

  def input_valid?(origin_port, destination_port, criteria)
    return false unless origin_port && destination_port && criteria
    return false if origin_port.length >= 100 || destination_port.length >= 100 || criteria.length >= 100
    return false unless ['cheapest-direct', 'cheapest', 'fastest'].include?(criteria)

    true
  end
end

ShippingCalculator.new.calculate

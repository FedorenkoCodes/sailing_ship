# frozen_string_literal: true

require_relative 'base_calculator'

class CheapestDirectCalculator < BaseCalculator
  def self.calculate(origin_port, destination_port)
    filtered_sailings = DataProvider.instance.sailings.select do |sailing|
      sailing['origin_port'] == origin_port && sailing['destination_port'] == destination_port
    end

    if filtered_sailings.empty?
      puts "No sailings found between #{origin_port} and #{destination_port}"
      return []
    end

    filtered_sailings.each { |sailing| populate_rate(sailing) }

    cheapest_sailing = filtered_sailings.min_by { |sailing| sailing['converted_rate'].to_f }

    [cheapest_sailing]
  end
end

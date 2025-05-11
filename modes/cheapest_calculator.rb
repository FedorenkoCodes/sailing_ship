# frozen_string_literal: true

require_relative 'base_calculator'

class CheapestCalculator < BaseCalculator
  def self.calculate(origin_port, destination_port)
    all_legs = find_all_legs(origin_port, destination_port, DataProvider.instance.sailings)

    if all_legs.empty?
      puts "No sailings found between #{origin_port} and #{destination_port}"
      return []
    end

    all_legs_with_rates = all_legs.map do |leg|
      {
        sailings: leg.each { |sailing| populate_rate(sailing) },
        total_rate: calculate_leg_total_rate(leg)
      }
    end

    cheapest_leg = all_legs_with_rates.min_by { |leg| leg[:total_rate] }

    cheapest_leg[:sailings]
  end

  def self.calculate_leg_total_rate(sailings)
    sailings.sum { |sailing| sailing['converted_rate'] }.round(2)
  end
end

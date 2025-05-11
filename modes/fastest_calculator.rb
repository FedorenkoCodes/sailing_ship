# frozen_string_literal: true

require_relative 'base_calculator'
require 'date'

class FastestCalculator < BaseCalculator
  def self.calculate(origin_port, destination_port)
    all_legs = find_all_legs(origin_port, destination_port, DataProvider.instance.sailings)

    if all_legs.empty?
      puts "No sailings found between #{origin_port} and #{destination_port}"
      return []
    end

    all_legs_with_durations = all_legs.map do |leg|
      {
        sailings: leg.each { |sailing| populate_rate(sailing) },
        total_duration: calculate_leg_total_duration(leg)
      }
    end

    fastest_leg = all_legs_with_durations.min_by { |leg| leg[:total_duration] }

    fastest_leg[:sailings]
  end

  def self.calculate_leg_total_duration(sailings)
    sailings.map do |sailing|
      (Date.parse(sailing['arrival_date']) - Date.parse(sailing['departure_date'])).to_i
    end.sum
  end
end

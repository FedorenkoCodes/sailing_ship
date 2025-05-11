require_relative 'base_calculator'
require 'date'

class FastestCalculator < BaseCalculator
  def self.calculate(origin_port, destination_port)
    all_legs = find_all_legs(origin_port, destination_port, DataProvider.instance.sailings)

    raise "No legs found between #{origin_port} and #{destination_port}" if all_legs.empty?

    all_legs_with_durations = []

    all_legs.each do |leg|
      all_legs_with_durations << {
        sailings: leg.each { |sailing| populate_rate(sailing) },
        total_duration: calculate_leg_total_duration(leg)
      }
    end

    fastest_leg = all_legs_with_durations.min_by { |leg| leg[:total_duration] }

    fastest_leg[:sailings]
  end

  private

  def self.calculate_leg_total_duration(sailings)
    duration = 0

    sailings.each do |sailing|
      departure_date = Date.parse(sailing['departure_date'])
      arrival_date = Date.parse(sailing['arrival_date'])
      duration += (arrival_date - departure_date).to_i
    end

    duration
  end
end

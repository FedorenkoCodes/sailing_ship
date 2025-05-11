require_relative 'base_calculator'

class CheapestCalculator < BaseCalculator
  def self.calculate(origin_port, destination_port)
    all_legs = find_all_legs(origin_port, destination_port, DataProvider.instance.sailings)

    raise "No legs found between #{origin_port} and #{destination_port}" if all_legs.empty?

    all_legs_with_rates = []

    all_legs.each do |leg|
      all_legs_with_rates << {
        sailings: leg.each { |sailing| populate_rate(sailing) },
        total_rate: calculate_leg_total_rate(leg)
      }
    end

    cheapest_leg = all_legs_with_rates.min_by { |leg| leg[:total_rate] }

    cheapest_leg[:sailings]
  end

  private

  def self.find_all_legs(origin_port, destination_port, sailings, previous_arrival_date = nil)
    legs = []

    sailings.each do |sailing|
      next if previous_arrival_date && sailing['departure_date'] < previous_arrival_date

      if sailing['origin_port'] == origin_port
        if sailing['destination_port'] == destination_port
          legs << [populate_rate(sailing)]
        else
          remaining_sailings = sailings.reject { |s| s == sailing }
          next_legs = find_all_legs(sailing['destination_port'], destination_port, remaining_sailings, sailing['arrival_date'])
          next_legs.each do |next_leg|
            legs << [populate_rate(sailing)] + next_leg
          end
        end
      end
    end

    legs
  end

  private

  def self.calculate_leg_total_rate(sailings)
    sum = 0.0

    sailings.map do |sailing|
      sum += sailing['converted_rate']
    end

    sum.round(2)
  end
end

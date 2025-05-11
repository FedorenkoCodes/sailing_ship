require_relative 'base_calculator'

class CheapestCalculator < BaseCalculator
  def self.calculate(origin_port, destination_port)
    all_legs = find_all_legs(origin_port, destination_port, DataProvider.instance.sailings)

    raise "No legs found between #{origin_port} and #{destination_port}" if all_legs.empty?

    all_legs
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
end

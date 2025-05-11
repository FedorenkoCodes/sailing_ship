require_relative 'base_calculator'

class FastestCalculator < BaseCalculator
  def self.calculate(origin_port, destination_port)
    [DataProvider.instance.sailings.first]
  end
end

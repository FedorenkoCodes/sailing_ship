require_relative '../data_provider'

class FastestCalculator
  def self.calculate(origin_port, destination_port)
    [DataProvider.instance.sailings.first]
  end
end

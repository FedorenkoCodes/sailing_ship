class CheapestDirectCalculator
  def self.calculate(origin_port, destination_port)
    [
      {
        origin_port: origin_port,
        destination_port: destination_port,
        criteria: 'cheapest-direct',
      }
    ]
  end
end

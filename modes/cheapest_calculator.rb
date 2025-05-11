class CheapestCalculator
  def self.calculate(origin_port, destination_port)
    data = JSON.parse(File.read('response.json'))

    sailings = data['sailings']
    rates = data['rates']
    exchange_rates = data['exchange_rates']

    [sailings.first]
  end
end

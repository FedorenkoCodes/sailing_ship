require 'json'

class CheapestDirectCalculator
  def self.calculate(origin_port, destination_port)
    data = JSON.parse(File.read('response.json'))
    results = []

    sailings = data['sailings']
    rates = data['rates']

    filtered_sailings = sailings.select do |sailing|
      sailing['origin_port'] == origin_port && sailing['destination_port'] == destination_port
    end

    raise "No sailings found" if filtered_sailings.empty?

    filtered_sailings.each do |sailing|
      rate = rates.find { |r| r['sailing_code'] == sailing['sailing_code'] }

      raise "No rate found" if rate.nil?

      sailing['rate'] = rate['rate']
      sailing['converted_rate'] = rate['rate']
      sailing['rate_currency'] = rate['rate_currency']
    end

    cheapest_sailing = filtered_sailings.min_by { |s| s['converted_rate'].to_f }

    results << {
      origin_port: cheapest_sailing['origin_port'],
      destination_port: cheapest_sailing['destination_port'],
      departure_date: cheapest_sailing['departure_date'],
      arrival_date: cheapest_sailing['arrival_date'],
      sailing_code: cheapest_sailing['sailing_code'],
      rate: cheapest_sailing['rate'],
      rate_currency: cheapest_sailing['rate_currency']
    }

    results
  end
end

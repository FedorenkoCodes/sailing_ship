require 'json'
require_relative '../currency_converter'
require_relative '../data_provider'

class CheapestDirectCalculator
  def self.calculate(origin_port, destination_port)
    filtered_sailings = DataProvider.instance.sailings.select do |sailing|
      sailing['origin_port'] == origin_port && sailing['destination_port'] == destination_port
    end

    raise "No sailings found between #{origin_port} and #{destination_port}" if filtered_sailings.empty?

    filtered_sailings.each do |sailing|
      populate_rate(sailing)
    end

    cheapest_sailing = filtered_sailings.min_by { |s| s['converted_rate'].to_f }

    [cheapest_sailing]
  end

  private

  def self.populate_rate(sailing)
    rate = DataProvider.instance.rates.find { |r| r['sailing_code'] == sailing['sailing_code'] }

    raise "No rate found for sailing #{sailing['sailing_code']}" if rate.nil?

    sailing['rate'] = rate['rate'].to_f
    sailing['rate_currency'] = rate['rate_currency']
    sailing['converted_rate'] = CurrencyConverter.convert_to_eur(rate['rate'], rate['rate_currency'], sailing['departure_date'])

    sailing
  end
end

require_relative '../data_provider'
require_relative '../currency_converter'

class BaseCalculator
  def self.calculate(origin_port, destination_port)
    raise 'Not implemented'
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
